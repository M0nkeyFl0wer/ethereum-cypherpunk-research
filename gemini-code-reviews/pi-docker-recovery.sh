#!/bin/bash
# Pi Docker & Immich Recovery Script
# Created: 2025-10-13
# Issue: ghost-data SSD has I/O errors preventing Docker containers from running

echo "=== Pi Docker Recovery Steps ==="
echo ""

# STEP 1: Check current mount status
echo "STEP 1: Checking mounted drives..."
ssh mini-monkey@raspberrypi "df -h | grep -E 'Filesystem|ghost|sandisk|sony'"
echo ""

# STEP 2: Check if ghost-data drive is having issues
echo "STEP 2: Checking ghost-data drive errors..."
ssh mini-monkey@raspberrypi "dmesg | tail -50 | grep -i 'error\|failed\|ghost'"
echo ""

# STEP 3: Stop all Docker containers gracefully
echo "STEP 3: Stopping Docker containers..."
ssh mini-monkey@raspberrypi "docker stop \$(docker ps -aq) 2>/dev/null"
echo ""

# STEP 4: Stop Docker service
echo "STEP 4: Stopping Docker service..."
ssh mini-monkey@raspberrypi "sudo systemctl stop docker"
echo ""

# STEP 5: Check and potentially remount ghost-data
echo "STEP 5: Checking ghost-data mount..."
ssh mini-monkey@raspberrypi "mount | grep ghost"
echo ""

# STEP 6: Remount the drive (read-only first to check health)
echo "STEP 6: Attempting to remount ghost-data..."
# This step requires knowing the device name - user should verify
# ssh mini-monkey@raspberrypi "sudo umount /mnt/ghost-data"
# ssh mini-monkey@raspberrypi "sudo mount -o ro /dev/sdX /mnt/ghost-data"
echo "  >> Manual step: You may need to unmount and remount /mnt/ghost-data"
echo "  >> Find device: sudo lsblk"
echo "  >> Unmount: sudo umount /mnt/ghost-data"
echo "  >> Mount: sudo mount /dev/sdX /mnt/ghost-data"
echo ""

# STEP 7: Start Docker service
echo "STEP 7: Starting Docker service..."
ssh mini-monkey@raspberrypi "sudo systemctl start docker"
echo ""

# STEP 8: Wait for Docker to be ready
echo "STEP 8: Waiting for Docker to start..."
sleep 5
echo ""

# STEP 9: Check Docker status
echo "STEP 9: Checking Docker status..."
ssh mini-monkey@raspberrypi "sudo systemctl status docker | head -10"
echo ""

# STEP 10: Start Immich containers
echo "STEP 10: Starting Immich containers..."
ssh mini-monkey@raspberrypi "cd /mnt/*/immich && docker-compose up -d 2>/dev/null || echo 'Need to navigate to Immich directory manually'"
echo ""

# STEP 11: Verify Immich is running
echo "STEP 11: Checking Immich status..."
ssh mini-monkey@raspberrypi "docker ps | grep immich"
echo ""

echo "=== Recovery complete! ==="
