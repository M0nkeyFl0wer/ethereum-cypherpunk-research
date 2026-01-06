#!/bin/bash
# Setup Tableau VM on Desktop (monk)
# Using the Extreme SSD with 445GB free space

echo "=== Tableau VM Setup on Desktop (monk) ==="
echo ""
echo "Desktop specs:"
echo "  CPU: AMD Ryzen 5 2600 (6 cores)"
echo "  RAM: 16GB (5GB available)"
echo "  Storage: Extreme SSD with 445GB free"
echo ""

# Step 1: Check if VirtualBox is installed
echo "Step 1: Checking for VirtualBox on desktop..."
if ssh monk "which virtualbox" 2>/dev/null; then
    echo "✅ VirtualBox already installed"
else
    echo "VirtualBox not found. Installing..."
    echo ""
    read -p "Install VirtualBox on desktop? (y/n): " INSTALL
    if [ "$INSTALL" = "y" ]; then
        ssh monk "sudo apt update && sudo apt install virtualbox virtualbox-ext-pack -y"
    else
        echo "Cancelled. Install VirtualBox manually first."
        exit 1
    fi
fi
echo ""

# Step 2: Create VM directory on SSD
echo "Step 2: Creating VM directory on Extreme SSD..."
VM_PATH="/media/m0nkey-fl0wer/Extreme_SSD/VirtualMachines"
ssh monk "mkdir -p $VM_PATH"
echo "Created: $VM_PATH"
echo ""

# Step 3: Check for Windows ISO
echo "Step 3: Windows ISO"
echo ""
echo "You need a Windows ISO file to install."
echo "Download from:"
echo "  - Windows 11: https://www.microsoft.com/software-download/windows11"
echo "  - Windows 10: https://www.microsoft.com/software-download/windows10"
echo ""
echo "After downloading, copy to desktop:"
echo "  scp ~/Downloads/windows.iso monk:$VM_PATH/"
echo ""
read -p "Do you have Windows ISO ready? (y/n): " HAS_ISO
if [ "$HAS_ISO" != "y" ]; then
    echo "Download Windows ISO first, then rerun this script."
    exit 0
fi
echo ""

# Step 4: Create VM
echo "Step 4: Creating Virtual Machine..."
echo ""
VM_NAME="TableauVM"
VM_DISK_SIZE=51200  # 50GB in MB

ssh monk "VBoxManage createvm --name '$VM_NAME' \
  --ostype 'Windows10_64' \
  --register \
  --basefolder '$VM_PATH'"

echo "✅ VM created"
echo ""

# Step 5: Configure VM
echo "Step 5: Configuring VM resources..."
ssh monk "VBoxManage modifyvm '$VM_NAME' \
  --memory 4096 \
  --cpus 4 \
  --vram 128 \
  --nic1 nat \
  --audio none \
  --usb on \
  --graphicscontroller vmsvga"

echo "✅ Configured: 4GB RAM, 4 CPU cores"
echo ""

# Step 6: Create virtual hard disk
echo "Step 6: Creating 50GB virtual hard disk..."
ssh monk "VBoxManage createhd \
  --filename '$VM_PATH/$VM_NAME/$VM_NAME.vdi' \
  --size $VM_DISK_SIZE \
  --variant Standard"

echo "✅ Virtual disk created"
echo ""

# Step 7: Attach storage controllers
echo "Step 7: Setting up storage..."
ssh monk "VBoxManage storagectl '$VM_NAME' \
  --name 'SATA Controller' \
  --add sata \
  --bootable on"

ssh monk "VBoxManage storageattach '$VM_NAME' \
  --storagectl 'SATA Controller' \
  --port 0 \
  --device 0 \
  --type hdd \
  --medium '$VM_PATH/$VM_NAME/$VM_NAME.vdi'"

echo "✅ Virtual disk attached"
echo ""

# Step 8: Attach Windows ISO
echo "Step 8: What is the Windows ISO filename?"
read -p "ISO filename (e.g., windows11.iso): " ISO_NAME

ssh monk "VBoxManage storagectl '$VM_NAME' \
  --name 'IDE Controller' \
  --add ide"

ssh monk "VBoxManage storageattach '$VM_NAME' \
  --storagectl 'IDE Controller' \
  --port 0 \
  --device 0 \
  --type dvddrive \
  --medium '$VM_PATH/$ISO_NAME'"

echo "✅ Windows ISO attached"
echo ""

# Step 9: Enable RDP for remote access
echo "Step 9: Enabling remote access..."
ssh monk "VBoxManage modifyvm '$VM_NAME' --vrde on --vrdeport 5001"
echo "✅ RDP enabled on port 5001"
echo ""

# Summary
echo "=== Setup Complete! ==="
echo ""
echo "VM Location: monk:$VM_PATH/$VM_NAME"
echo "VM Disk: 50GB on Extreme SSD"
echo "VM Resources: 4 CPU cores, 4GB RAM"
echo ""
echo "Next Steps:"
echo ""
echo "1. Start VM from desktop:"
echo "   ssh monk \"VBoxManage startvm $VM_NAME --type headless\""
echo ""
echo "2. Access from laptop via RDP:"
echo "   rdesktop monk:5001"
echo "   or use Remmina/any RDP client"
echo ""
echo "3. Install Windows in the VM"
echo ""
echo "4. After Windows is installed, download Tableau:"
echo "   https://www.tableau.com/products/desktop/download"
echo ""
echo "5. Access Tableau anytime:"
echo "   ssh monk \"VBoxManage startvm $VM_NAME --type headless\""
echo "   rdesktop monk:5001"
echo ""
