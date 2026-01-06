#!/bin/bash
# Fix SanDisk SSD I/O Errors on Raspberry Pi 5
# Common issue with USB SSDs on Pi - needs proper power and quirks

echo "=== SanDisk SSD Fix for Raspberry Pi 5 ==="
echo ""
echo "Common issues:"
echo "1. USB power insufficient for SSD"
echo "2. TRIM/UASP incompatibility"
echo "3. Incorrect mount options"
echo ""

# STEP 1: Check current USB configuration
echo "STEP 1: Checking USB configuration..."
echo "Running: lsusb"
echo ""
ssh mini-monkey@raspberrypi "lsusb"
echo ""
echo "---"
echo ""

# STEP 2: Check dmesg for errors
echo "STEP 2: Checking system log for USB/disk errors..."
echo "Running: dmesg | tail -50 | grep -i 'usb\|sda\|error'"
echo ""
ssh mini-monkey@raspberrypi "dmesg | tail -50 | grep -i 'usb\|sda\|error\|uas'"
echo ""
echo "---"
echo ""

# STEP 3: Check current mount options
echo "STEP 3: Checking how SSD is currently mounted..."
echo "Running: mount | grep sda"
echo ""
ssh mini-monkey@raspberrypi "mount | grep sda"
echo ""
echo "---"
echo ""

# STEP 4: Check /etc/fstab
echo "STEP 4: Checking /etc/fstab configuration..."
echo "Running: cat /etc/fstab | grep -v '^#'"
echo ""
ssh mini-monkey@raspberrypi "cat /etc/fstab | grep -v '^#' | grep -v '^$'"
echo ""
echo "---"
echo ""

echo "=== DIAGNOSIS COMPLETE ==="
echo ""
echo "Now run the appropriate fix script:"
echo "  - If USB power issue: ./fix-pi-ssd-power.sh"
echo "  - If TRIM/UAS issue: ./fix-pi-ssd-uas.sh"
echo "  - If mount options: ./fix-pi-ssd-mount.sh"
echo ""
