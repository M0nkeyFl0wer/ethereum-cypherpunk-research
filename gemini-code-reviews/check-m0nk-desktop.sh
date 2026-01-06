#!/bin/bash
# Check m0nk Desktop Specifications
# Determine if desktop is suitable for Tableau VM

echo "=== Checking m0nk Desktop Specs ==="
echo ""

# Check if we can connect
echo "Step 1: Testing connection to m0nk..."
if ! ssh m0nk "echo 'Connected!'" 2>/dev/null; then
    echo "❌ Cannot connect to m0nk"
    echo ""
    echo "Possible issues:"
    echo "1. SSH keys not set up"
    echo "2. Different username"
    echo "3. Device is offline"
    echo ""
    echo "Try manually:"
    echo "  ssh m0nk"
    echo "  Or: ssh YOUR_USERNAME@m0nk"
    exit 1
fi

echo "✅ Connected to m0nk"
echo ""

# Get hostname
echo "Step 2: Device information"
echo "Command: hostname"
echo ""
HOSTNAME=$(ssh m0nk "hostname")
echo "Hostname: $HOSTNAME"
echo ""

# Get CPU info
echo "Step 3: CPU Information"
echo "Command: grep 'model name' /proc/cpuinfo | head -1"
echo ""
CPU=$(ssh m0nk "grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs")
CORES=$(ssh m0nk "grep 'cpu cores' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs")
echo "CPU: $CPU"
echo "Cores: $CORES"
echo ""

# Get RAM info
echo "Step 4: Memory (RAM)"
echo "Command: free -h"
echo ""
ssh m0nk "free -h | grep -E 'total|Mem'"
RAM=$(ssh m0nk "free -h | grep Mem | awk '{print \$2}'")
echo "Total RAM: $RAM"
echo ""

# Get disk space
echo "Step 5: Disk Space"
echo "Command: df -h /"
echo ""
ssh m0nk "df -h / | grep -E 'Size|/dev/'"
DISK_FREE=$(ssh m0nk "df -h / | tail -1 | awk '{print \$4}'")
echo "Available: $DISK_FREE"
echo ""

# Check if virtualization is enabled
echo "Step 6: Virtualization Support"
echo "Command: egrep -c '(vmx|svm)' /proc/cpuinfo"
echo "Explanation: Checks if CPU supports VMs"
echo ""
VT=$(ssh m0nk "egrep -c '(vmx|svm)' /proc/cpuinfo")
if [ "$VT" -gt 0 ]; then
    echo "✅ Virtualization supported ($VT cores)"
else
    echo "⚠️ Virtualization not detected (VM will be slow)"
fi
echo ""

# Check if VirtualBox is installed
echo "Step 7: Check for existing VM software"
echo "Command: which virtualbox virt-manager"
echo ""
ssh m0nk "which virtualbox 2>/dev/null && echo 'VirtualBox: Installed' || echo 'VirtualBox: Not installed'"
ssh m0nk "which virt-manager 2>/dev/null && echo 'KVM: Installed' || echo 'KVM: Not installed'"
echo ""

# Summary
echo "=== SUMMARY ==="
echo ""
echo "Device: $HOSTNAME (m0nk)"
echo "CPU: $CPU ($CORES cores)"
echo "RAM: $RAM"
echo "Disk Free: $DISK_FREE"
echo "Virtualization: $([ "$VT" -gt 0 ] && echo 'Supported' || echo 'Not supported')"
echo ""
echo "=== RECOMMENDATION ==="
echo ""

# Parse disk free (rough)
DISK_NUM=$(echo $DISK_FREE | sed 's/[^0-9.]//g')
RAM_NUM=$(echo $RAM | sed 's/[^0-9.]//g')

if (( $(echo "$DISK_NUM > 50" | bc -l 2>/dev/null || echo 0) )); then
    if (( $(echo "$RAM_NUM >= 8" | bc -l 2>/dev/null || echo 0) )); then
        echo "✅ EXCELLENT - Use this desktop for Tableau VM!"
        echo ""
        echo "This desktop has:"
        echo "  - Enough disk space ($DISK_FREE > 50GB needed)"
        echo "  - Enough RAM ($RAM >= 8GB recommended)"
        echo "  - Proper CPU ($CORES cores)"
        echo ""
        echo "Next step: Run ./setup-tableau-vm-desktop.sh"
    else
        echo "⚠️ POSSIBLE - Has disk space but limited RAM"
        echo "Tableau might be slow with < 8GB RAM"
        echo ""
        echo "Consider laptop or add more RAM to desktop"
    fi
else
    echo "❌ INSUFFICIENT DISK SPACE"
    echo "Need 50GB+, have $DISK_FREE"
    echo ""
    echo "Options:"
    echo "  1. Clean up desktop space"
    echo "  2. Use laptop with Pi storage (Path C)"
    echo "  3. Add external drive to desktop"
fi

echo ""
