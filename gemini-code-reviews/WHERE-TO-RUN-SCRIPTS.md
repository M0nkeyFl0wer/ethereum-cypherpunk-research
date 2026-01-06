# Where to Run Each Script

**Simple Rule**: Run everything from your **laptop** (FlowerPowered) unless specified otherwise.

The scripts use SSH to connect to Pi and desktop remotely.

---

## Scripts - Where to Run

### ✅ Run on LAPTOP (FlowerPowered)

These scripts connect to remote machines automatically via SSH:

```bash
# Check desktop specs (SSHs to m0nk)
./check-m0nk-desktop.sh

# Fix Pi SSD (SSHs to Pi)
./fix-pi-ssd-uas-quirks.sh
./fix-pi-ssd-io-errors.sh

# Immich setup (SSHs to Pi)
./fix-immich-steps.sh
./quick-fix-immich.sh

# Clean your laptop (runs locally)
./cleanup-laptop-space.sh
```

**Why from laptop?**
- You're already on the laptop
- Scripts use SSH commands like `ssh mini-monkey@raspberrypi "command"`
- Your SSH keys are set up on laptop

---

## Understanding How Scripts Work

### Example: check-m0nk-desktop.sh

When you run this **on your laptop**:
```bash
./check-m0nk-desktop.sh
```

**What happens**:
1. Script runs on laptop
2. Script sends commands to desktop via SSH
3. Desktop executes commands
4. Results come back to laptop
5. Script shows you results

**The script contains**:
```bash
ssh m0nk "df -h"  # This runs df -h on m0nk, not locally
```

---

## If SSH Doesn't Work

### Problem: Can't connect to m0nk
```bash
./check-m0nk-desktop.sh
# Error: ssh_askpass... Permission denied
```

**Solution**: Need to set up SSH keys or try different username

**Option 1: Manual check on desktop**
```bash
# Physically go to desktop, or if you can access it:
ssh USERNAME@m0nk   # Try your actual username

# Once connected, run these commands directly:
hostname
grep 'model name' /proc/cpuinfo | head -1
free -h
df -h /
```

**Option 2: Set up SSH keys** (for passwordless login)
```bash
# On laptop, generate key if you don't have one
ssh-keygen -t ed25519

# Copy key to desktop
ssh-copy-id USERNAME@m0nk

# Now scripts will work automatically
```

---

## If You Want to Run Commands Directly on Each Machine

### On Desktop (m0nk)

First SSH into it:
```bash
ssh m0nk  # or ssh USERNAME@m0nk
```

Then run these commands **directly on desktop**:
```bash
# Check specs
grep 'model name' /proc/cpuinfo | head -1
free -h
df -h /

# Install VirtualBox (if desktop has good specs)
sudo apt update
sudo apt install virtualbox virtualbox-ext-pack -y
```

### On Pi (raspberrypi)

First SSH into it:
```bash
ssh mini-monkey@raspberrypi
```

Then run these commands **directly on Pi**:
```bash
# Check USB devices
lsusb | grep -i sandisk

# Apply SSD fix (after finding device ID)
echo "options usb-storage quirks=XXXX:XXXX:u" | \
  sudo tee /etc/modprobe.d/usb-storage-quirks.conf

sudo update-initramfs -u
sudo reboot
```

---

## Recommended Workflow

### Step 1: Stay on Laptop
```bash
cd /home/flower/gemini-code-reviews

# Make sure scripts are executable
chmod +x *.sh

# Check desktop specs (runs via SSH from laptop)
./check-m0nk-desktop.sh
```

### Step 2: If SSH Fails

**Manually check desktop:**
```bash
# Try to connect
ssh m0nk

# If that doesn't work, try:
ssh YOUR_USERNAME@m0nk
# or
ssh YOUR_USERNAME@100.93.131.84
```

**Once connected to desktop, run:**
```bash
hostname
grep 'model name' /proc/cpuinfo | head -1
free -h | grep Mem
df -h / | tail -1
```

**Then exit back to laptop:**
```bash
exit
```

### Step 3: Fix Pi SSD (from laptop)
```bash
# This SSHs to Pi automatically
./fix-pi-ssd-uas-quirks.sh
```

### Step 4: Clean Laptop (local)
```bash
# This runs locally on laptop
./cleanup-laptop-space.sh
```

---

## Python Learning: Understanding Local vs Remote

### Local Command (runs on current machine)
```bash
df -h
# Shows disk space on the machine you're currently on
```

### Remote Command (runs on another machine)
```bash
ssh mini-monkey@raspberrypi "df -h"
# Shows disk space on raspberrypi, not your current machine
```

### Visualizing It

```
┌─────────────────────────────────────┐
│  Your Laptop (FlowerPowered)        │
│                                     │
│  $ ./check-m0nk-desktop.sh          │
│    │                                │
│    │ Script contains:               │
│    │ ssh m0nk "df -h"              │
│    │         │                      │
│    │         └────────┐             │
│    │                  │             │
└────│──────────────────│─────────────┘
     │                  │
     │             Network (Tailscale)
     │                  │
     ↓                  ↓
┌────────────────────────────────┐
│  Desktop (m0nk)                │
│                                │
│  Receives: df -h               │
│  Executes: df -h               │
│  Returns: disk space info      │
│         │                      │
└─────────│──────────────────────┘
          │
          └──(sends results back)──→ Laptop
```

---

## Summary Table

| Script | Run From | Connects To | Purpose |
|--------|----------|-------------|---------|
| `check-m0nk-desktop.sh` | Laptop | Desktop (m0nk) | Check desktop specs |
| `fix-pi-ssd-uas-quirks.sh` | Laptop | Pi | Fix SSD errors |
| `fix-pi-ssd-io-errors.sh` | Laptop | Pi | Diagnose SSD |
| `cleanup-laptop-space.sh` | Laptop | Laptop (local) | Free disk space |
| `quick-fix-immich.sh` | Laptop | Pi | Restart Immich |

---

## Quick Start (TL;DR)

**Just run everything from your laptop:**
```bash
cd /home/flower/gemini-code-reviews

# Check desktop
./check-m0nk-desktop.sh

# Fix Pi (after checking desktop)
./fix-pi-ssd-uas-quirks.sh

# Clean laptop if needed
./cleanup-laptop-space.sh
```

**If SSH fails**, manually connect to check:
```bash
ssh m0nk            # for desktop
ssh mini-monkey@raspberrypi   # for Pi
```

---

Need help with SSH setup? Let me know!
