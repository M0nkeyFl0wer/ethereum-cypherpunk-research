#!/bin/bash
# Quick Tableau VM Setup - Get Working Today
# Location: /mnt/data on desktop (monk)

set -e  # Exit on any error

echo "=== Quick Tableau VM Setup ==="
echo ""
echo "This will:"
echo "  1. Check/install VirtualBox on desktop"
echo "  2. Create 40GB VM on /mnt/data (647GB free)"
echo "  3. Set up for remote access from laptop"
echo "  4. Get you working on Tableau today"
echo ""
read -p "Continue? (y/n): " CONTINUE
if [ "$CONTINUE" != "y" ]; then exit 0; fi

# Variables
VM_NAME="TableauVM"
VM_PATH="/mnt/data/VirtualMachines"
VM_SIZE=40960  # 40GB in MB
VM_RAM=4096    # 4GB RAM
VM_CPUS=4      # 4 CPU cores

echo ""
echo "Step 1/7: Checking VirtualBox on desktop..."
if ssh monk "which VBoxManage" &>/dev/null; then
    echo "✅ VirtualBox already installed"
else
    echo "Installing VirtualBox..."
    ssh monk "sudo apt update && sudo apt install -y virtualbox virtualbox-ext-pack"
    echo "✅ VirtualBox installed"
fi

echo ""
echo "Step 2/7: Creating VM directory..."
ssh monk "mkdir -p $VM_PATH"
echo "✅ Directory created: $VM_PATH"

echo ""
echo "Step 3/7: Creating virtual machine..."
ssh monk "VBoxManage createvm --name '$VM_NAME' \
    --ostype 'Windows10_64' \
    --register \
    --basefolder '$VM_PATH'"
echo "✅ VM created"

echo ""
echo "Step 4/7: Configuring VM (4 cores, 4GB RAM)..."
ssh monk "VBoxManage modifyvm '$VM_NAME' \
    --memory $VM_RAM \
    --cpus $VM_CPUS \
    --vram 128 \
    --graphicscontroller vmsvga \
    --accelerate3d on \
    --audio none \
    --nic1 nat \
    --natpf1 'rdp,tcp,,3390,,3389' \
    --clipboard bidirectional \
    --draganddrop bidirectional \
    --usb on \
    --vrde on \
    --vrdeport 5001"
echo "✅ VM configured"

echo ""
echo "Step 5/7: Creating 40GB virtual hard disk..."
ssh monk "VBoxManage createhd \
    --filename '$VM_PATH/$VM_NAME/$VM_NAME.vdi' \
    --size $VM_SIZE \
    --variant Standard"
echo "✅ Disk created"

echo ""
echo "Step 6/7: Attaching storage..."
ssh monk "VBoxManage storagectl '$VM_NAME' \
    --name 'SATA' \
    --add sata \
    --controller IntelAhci \
    --portcount 2 \
    --bootable on"

ssh monk "VBoxManage storageattach '$VM_NAME' \
    --storagectl 'SATA' \
    --port 0 \
    --device 0 \
    --type hdd \
    --medium '$VM_PATH/$VM_NAME/$VM_NAME.vdi'"
echo "✅ Disk attached"

echo ""
echo "Step 7/7: Setting up Windows ISO..."
echo ""
echo "IMPORTANT: You need a Windows 10/11 ISO"
echo ""
echo "Option 1 - Download now (recommended):"
echo "  Press Ctrl+C, run this on your laptop:"
echo "  wget https://software-download.microsoft.com/pr/Win10_22H2_English_x64.iso -O ~/Downloads/windows10.iso"
echo "  Then: scp ~/Downloads/windows10.iso monk:/mnt/data/VirtualMachines/"
echo ""
echo "Option 2 - Manual download:"
echo "  Visit: https://www.microsoft.com/software-download/windows10"
echo "  Download ISO, then: scp ~/Downloads/Win*.iso monk:/mnt/data/VirtualMachines/"
echo ""
read -p "Enter ISO filename on desktop (e.g., windows10.iso) or 'skip': " ISO_NAME

if [ "$ISO_NAME" != "skip" ] && [ -n "$ISO_NAME" ]; then
    # Check if ISO exists
    if ssh monk "test -f /mnt/data/VirtualMachines/$ISO_NAME"; then
        echo "✅ Found ISO: $ISO_NAME"

        ssh monk "VBoxManage storagectl '$VM_NAME' --name 'IDE' --add ide"
        ssh monk "VBoxManage storageattach '$VM_NAME' \
            --storagectl 'IDE' \
            --port 0 \
            --device 0 \
            --type dvddrive \
            --medium '/mnt/data/VirtualMachines/$ISO_NAME'"
        echo "✅ Windows ISO attached"
        ISO_READY=true
    else
        echo "⚠️  ISO not found at: /mnt/data/VirtualMachines/$ISO_NAME"
        echo "Upload it first, then run:"
        echo "  ssh monk \"VBoxManage storagectl '$VM_NAME' --name 'IDE' --add ide\""
        echo "  ssh monk \"VBoxManage storageattach '$VM_NAME' --storagectl 'IDE' --port 0 --device 0 --type dvddrive --medium '/mnt/data/VirtualMachines/$ISO_NAME'\""
        ISO_READY=false
    fi
else
    echo "Skipped ISO attachment. Attach later with:"
    echo "  ssh monk \"VBoxManage storagectl '$VM_NAME' --name 'IDE' --add ide\""
    echo "  ssh monk \"VBoxManage storageattach '$VM_NAME' --storagectl 'IDE' --port 0 --device 0 --type dvddrive --medium '/mnt/data/VirtualMachines/YOUR_ISO.iso'\""
    ISO_READY=false
fi

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "VM Location: monk:/mnt/data/VirtualMachines/$VM_NAME"
echo "VM Resources: 4 CPU cores, 4GB RAM, 40GB disk"
echo ""

if [ "$ISO_READY" = true ]; then
    echo "✅ Ready to start!"
    echo ""
    echo "Next steps:"
    echo ""
    echo "1. Start the VM (headless mode):"
    echo "   ssh monk \"VBoxManage startvm $VM_NAME --type headless\""
    echo ""
    echo "2. Connect from your laptop:"
    echo "   remmina -c rdp://monk:5001"
    echo "   (or any RDP client: monk:5001)"
    echo ""
    echo "3. Install Windows (follow on-screen prompts)"
    echo ""
    echo "4. Inside Windows, install Tableau:"
    echo "   https://www.tableau.com/products/desktop/download"
    echo ""
    echo "5. Use Tableau!"
    echo ""
    echo "To stop VM later:"
    echo "   ssh monk \"VBoxManage controlvm $VM_NAME acpipowerbutton\""
    echo ""
else
    echo "⚠️  Next: Upload Windows ISO first"
    echo ""
    echo "On laptop, download Windows:"
    echo "  wget https://software-download.microsoft.com/pr/Win10_22H2_English_x64.iso -O ~/Downloads/windows10.iso"
    echo ""
    echo "Copy to desktop:"
    echo "  scp ~/Downloads/windows10.iso monk:/mnt/data/VirtualMachines/"
    echo ""
    echo "Attach ISO:"
    echo "  ssh monk \"VBoxManage storagectl '$VM_NAME' --name 'IDE' --add ide\""
    echo "  ssh monk \"VBoxManage storageattach '$VM_NAME' --storagectl 'IDE' --port 0 --device 0 --type dvddrive --medium '/mnt/data/VirtualMachines/windows10.iso'\""
    echo ""
    echo "Then start VM:"
    echo "  ssh monk \"VBoxManage startvm $VM_NAME --type headless\""
    echo ""
fi

echo "Quick Reference Card saved to: tableau-vm-commands.txt"

# Create quick reference
cat > /home/flower/gemini-code-reviews/tableau-vm-commands.txt << 'EOF'
# Tableau VM Quick Commands

## Start VM (from laptop)
ssh monk "VBoxManage startvm TableauVM --type headless"

## Connect to VM (from laptop)
remmina -c rdp://monk:5001
# Or use IP: monk's Tailscale IP is 100.93.131.84
# So: remmina -c rdp://100.93.131.84:5001

## Stop VM gracefully
ssh monk "VBoxManage controlvm TableauVM acpipowerbutton"

## Force stop VM (if frozen)
ssh monk "VBoxManage controlvm TableauVM poweroff"

## Check VM status
ssh monk "VBoxManage showvminfo TableauVM | grep State"

## List all VMs
ssh monk "VBoxManage list vms"

## VM location
/mnt/data/VirtualMachines/TableauVM/

## Snapshot (backup before changes)
ssh monk "VBoxManage snapshot TableauVM take 'BeforeTableauInstall'"

## Restore snapshot
ssh monk "VBoxManage snapshot TableauVM restore 'BeforeTableauInstall'"

## Access from phone
Install: Microsoft Remote Desktop app
Connect to: 100.93.131.84:5001

## Tableau download
https://www.tableau.com/products/desktop/download

## Data folders (create in Windows)
C:\TableauData\ - for your data files
Map network drive to Extreme SSD for shared data
EOF

echo ""
