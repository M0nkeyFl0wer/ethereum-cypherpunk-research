#!/bin/bash
# Immich Server Setup Reference
# Created: 2025-10-13
# Updated: 2025-10-13

# ===========================================
# SERVER INFORMATION
# ===========================================
# Your Pi's Tailscale IP: 100.75.223.48
# Your Pi's hostname: raspberrypi
# Your Pi username: mini-monkey
# Immich Server URL: http://100.75.223.48:2283
# Immich Location on Pi: /media/sandisk/immich
# Storage: SanDisk 58GB (ghost-data) mounted at /media/sandisk

# ===========================================
# STEP 1: TEST SERVER CONNECTIVITY
# ===========================================
# Test if Immich server is accessible
curl -I http://100.75.223.48:2283/api/server-info

# Alternative: Test with browser
# Open this URL in your browser: http://100.75.223.48:2283

# ===========================================
# STEP 2: CHECK IMMICH PORT ON PI (if needed)
# ===========================================
# If you need to verify the port, run this on the Pi:
# ssh ben@raspberrypi "docker ps | grep immich"
# or
# ssh ben@raspberrypi "sudo netstat -tlnp | grep immich"

# ===========================================
# STEP 3: DESKTOP CLIENT SETUP
# ===========================================
# If using Immich desktop app:
# 1. Open Immich application
# 2. Enter server URL: http://100.75.223.48:2283
# 3. Login with your credentials

# If using web browser:
# Just navigate to: http://100.75.223.48:2283

# ===========================================
# STEP 4: MOBILE (ANDROID) SETUP
# ===========================================
# On your OnePlus phone (oneplus-cph2551):
# 1. Make sure Tailscale is connected on your phone
# 2. Open Immich app
# 3. Tap "Connect to server"
# 4. Enter: http://100.75.223.48:2283
# 5. Login with your credentials
# 6. Enable auto-backup in settings if desired

# ===========================================
# TAILSCALE STATUS CHECK
# ===========================================
# View all Tailscale devices
tailscale status

# Check if Pi is reachable
ping -c 3 100.75.223.48

# ===========================================
# TROUBLESHOOTING
# ===========================================
# If server not accessible:
# 1. Verify Tailscale is connected on both devices
# 2. Check if Immich container is running on Pi
# 3. Check firewall rules on Pi
# 4. Verify port number (might be 2283, 2284, or custom)

# Check Tailscale connection
tailscale status | grep raspberrypi

# Test network connectivity
nc -zv 100.75.223.48 2283
