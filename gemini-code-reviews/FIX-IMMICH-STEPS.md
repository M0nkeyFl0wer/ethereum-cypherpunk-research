# Fix Immich Server on Pi - Step by Step

**Issue**: ghost-data SSD is having I/O errors, Docker can't access containers
**Your Pi IP**: 100.75.223.48 (via Tailscale)
**Username**: mini-monkey
**Immich Location**: /media/sandisk/immich

---

## STEP 1: SSH into your Pi
```bash
ssh mini-monkey@raspberrypi
```

## STEP 2: Check the problem mount
```bash
# See if /mnt/ghost-data exists and is causing issues
ls -la /mnt/
mount | grep ghost
```

**Explanation**: Docker is trying to use `/mnt/ghost-data` but it's having I/O errors

---

## STEP 3: Stop Docker safely
```bash
# Stop Docker service to prevent corruption
sudo systemctl stop docker
```

**Explanation**: This prevents Docker from trying to write to the failing mount

---

## STEP 4: Check disk health
```bash
# Check system messages for disk errors
dmesg | tail -30 | grep -i error

# Check filesystem status
sudo fsck -n /dev/sda1
```

**Explanation**: This tells us if the SSD is failing physically

---

## STEP 5: Fix the mount issue
```bash
# If /mnt/ghost-data is a symlink or old mount, remove it
sudo umount /mnt/ghost-data 2>/dev/null

# Check if it's a symlink
ls -la /mnt/ghost-data

# If it's a broken symlink, remove it
sudo rm /mnt/ghost-data 2>/dev/null
```

**Explanation**: Clean up any conflicting mount points

---

## STEP 6: Verify good mount
```bash
# Your data should be accessible here
ls /media/sandisk/immich
df -h /media/sandisk
```

**Explanation**: Confirm the sandisk is mounted and accessible

---

## STEP 7: Restart Docker
```bash
# Start Docker fresh
sudo systemctl start docker

# Wait a few seconds
sleep 5

# Check status
sudo systemctl status docker
```

**Explanation**: Docker starts clean without the bad mount

---

## STEP 8: Start Immich
```bash
# Navigate to Immich directory
cd /media/sandisk/immich

# Start containers
docker-compose up -d

# Check if running
docker ps | grep immich
```

**Explanation**: This starts Immich server on port 2283

---

## STEP 9: Verify Immich is accessible
```bash
# From the Pi, test locally
curl http://localhost:2283/api/server-info

# Check the port
netstat -tlnp | grep 2283
```

**Explanation**: Confirms Immich is running and listening

---

## STEP 10: Test from your desktop (exit SSH first)
```bash
# Exit the Pi
exit

# From your desktop, test connection
curl http://100.75.223.48:2283/api/server-info
```

**Expected**: Should return JSON with server info

---

## Once Working - Configure Your Devices

### Desktop/Laptop Setup
- **Server URL**: `http://100.75.223.48:2283`
- Or use hostname: `http://raspberrypi:2283`

### Phone Setup (OnePlus)
1. Make sure Tailscale is connected on phone
2. Open Immich app
3. Enter server URL: `http://100.75.223.48:2283`
4. Login with your credentials

---

## If Still Having Issues

### Check Docker data root
```bash
# See where Docker stores data
docker info | grep "Docker Root Dir"
```

### If Docker root is on /mnt/ghost-data, change it
```bash
# Edit Docker daemon config
sudo nano /etc/docker/daemon.json

# Add or change:
{
  "data-root": "/media/sandisk/docker"
}

# Restart Docker
sudo systemctl restart docker
```

---

## Quick Reference Commands File
All commands saved in: `immich-setup-commands.sh`
