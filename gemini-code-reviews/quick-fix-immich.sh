#!/bin/bash
# Quick Immich Recovery Script
# Run this to attempt automatic recovery

echo "Starting Immich recovery on Pi..."

# Stop Docker
echo "1. Stopping Docker..."
ssh mini-monkey@raspberrypi "sudo systemctl stop docker"
sleep 3

# Start Docker
echo "2. Starting Docker..."
ssh mini-monkey@raspberrypi "sudo systemctl start docker"
sleep 5

# Start Immich
echo "3. Starting Immich containers..."
ssh mini-monkey@raspberrypi "cd /media/sandisk/immich && docker-compose up -d"
sleep 5

# Check status
echo "4. Checking Immich status..."
ssh mini-monkey@raspberrypi "docker ps | grep immich"

# Test connectivity
echo "5. Testing server..."
sleep 3
curl -s http://100.75.223.48:2283/api/server-info || echo "Server not responding yet, may need manual steps"

echo ""
echo "Done! If successful, use server URL: http://100.75.223.48:2283"
echo "If not working, follow steps in FIX-IMMICH-STEPS.md"
