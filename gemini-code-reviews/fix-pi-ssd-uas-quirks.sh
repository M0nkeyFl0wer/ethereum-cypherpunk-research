#!/bin/bash
# Fix SanDisk SSD UAS/TRIM Issues on Pi 5
# This is the most common fix for I/O errors

echo "=== Applying USB Quirks for SanDisk SSD ==="
echo ""

# What this does:
# USB devices sometimes use UAS (USB Attached SCSI) for speed
# But some SSDs have buggy UAS firmware
# This disables UAS for your specific SSD

echo "STEP 1: Identify your SSD device ID"
echo "Running: lsusb to find the SSD"
echo ""
ssh mini-monkey@raspberrypi "lsusb | grep -i 'sandisk\|storage\|mass'"
echo ""

echo "Look for your SanDisk SSD in the output above"
echo "It will show something like: Bus 002 Device 003: ID 0781:5583 SanDisk Corp"
echo ""
read -p "Enter the device ID (format: 0781:5583): " DEVICE_ID

if [ -z "$DEVICE_ID" ]; then
    echo "No device ID entered. Exiting."
    exit 1
fi

echo ""
echo "STEP 2: Creating USB quirks configuration"
echo ""

# Create the quirks command
echo "This command disables UAS for your device"
echo "Running on Pi:"
echo "sudo sh -c 'echo \"options usb-storage quirks=$DEVICE_ID:u\" > /etc/modprobe.d/usb-storage-quirks.conf'"
echo ""

ssh mini-monkey@raspberrypi "sudo sh -c 'echo \"options usb-storage quirks=$DEVICE_ID:u\" > /etc/modprobe.d/usb-storage-quirks.conf'"

echo ""
echo "STEP 3: Rebuilding initramfs"
echo "This ensures the quirk is loaded at boot"
echo ""
ssh mini-monkey@raspberrypi "sudo update-initramfs -u"

echo ""
echo "STEP 4: Reboot required"
echo ""
echo "The Pi needs to reboot for changes to take effect."
echo ""
read -p "Reboot Pi now? (y/n): " REBOOT

if [ "$REBOOT" = "y" ]; then
    echo "Rebooting Pi..."
    ssh mini-monkey@raspberrypi "sudo reboot"
    echo ""
    echo "Pi is rebooting. Wait 1-2 minutes, then run:"
    echo "  ssh mini-monkey@raspberrypi 'df -h | grep sandisk'"
    echo "  ssh mini-monkey@raspberrypi 'dmesg | grep -i error'"
else
    echo ""
    echo "When ready, reboot with:"
    echo "  ssh mini-monkey@raspberrypi 'sudo reboot'"
fi

echo ""
echo "=== Fix Applied ==="
echo ""
echo "What we did:"
echo "1. Found your SSD's USB ID: $DEVICE_ID"
echo "2. Told Linux to use 'usb-storage' instead of UAS mode"
echo "3. Updated boot configuration"
echo "4. Reboot will activate the fix"
echo ""
