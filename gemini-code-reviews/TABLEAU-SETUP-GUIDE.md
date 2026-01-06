# Complete Tableau VM Setup Guide

**Date**: 2025-10-13
**Your Network**: Tailscale mesh (all devices connected)

---

## Quick Decision Tree

```
Do you want to use your desktop (m0nk)?
├─ YES → Best option! Desktop likely has most resources
│         └─ Follow: Path A (Desktop Setup)
│
└─ NO, use laptop
   │
   ├─ Want fastest performance?
   │  └─ YES → Clean laptop, install locally
   │           └─ Follow: Path B (Local VM)
   │
   └─ Want to save laptop space?
      └─ YES → Use Pi for storage
               └─ Follow: Path C (Pi Storage VM)
```

---

## PATH A: Desktop Setup (RECOMMENDED) ⭐

### Why Desktop is Best
- Likely more CPU/RAM/disk space
- Can run 24/7 without draining laptop battery
- Access Tableau from laptop via Tailscale
- The SSD is already connected to it

### Step 1: Check desktop specs

Run this script:
```bash
./check-m0nk-desktop.sh
```

Or manually:
```bash
ssh m0nk "
  grep 'model name' /proc/cpuinfo | head -1 &&
  free -h | grep Mem &&
  df -h / | tail -1
"
```

### Step 2: If desktop has good specs (8GB+ RAM, 50GB+ free)

Install VirtualBox on desktop:
```bash
ssh m0nk "
  sudo apt update &&
  sudo apt install virtualbox virtualbox-ext-pack -y
"
```

### Step 3: Set up VM on desktop

See: `setup-tableau-vm-desktop.sh`

### Step 4: Access from laptop

- Use VirtualBox's RDP or VNC
- Or use Windows RDP through Tailscale
- Work on Tableau from any device!

---

## PATH B: Local VM on Laptop

### Pros
- Fastest performance
- No network dependency

### Cons
- Need to clean 6-15GB
- Laptop disk still tight

### Steps

**1. Clean up space**
```bash
./cleanup-laptop-space.sh
```

**Learning**: This removes caches - temporary files that can be recreated

**2. Verify space**
```bash
df -h /
```

Should show ~8-17GB free after cleanup

**3. Install VirtualBox**
```bash
sudo apt update
sudo apt install virtualbox virtualbox-ext-pack -y
```

**Learning**:
- `apt update` = refresh package list (like checking app store for updates)
- `apt install` = download and install software
- `-y` = answer "yes" to all prompts automatically

**4. Download Windows ISO**
```bash
# Visit: https://www.microsoft.com/software-download/windows11
# Or use Windows 10: https://www.microsoft.com/software-download/windows10
```

**5. Create VM**
```bash
# Through GUI
VirtualBox &

# Or command line - see: setup-vm-cli.sh
```

**6. Install Tableau**

Inside Windows VM:
- Visit: https://www.tableau.com/products/desktop/download
- Download and install

---

## PATH C: Pi Storage VM

### Pros
- No laptop cleanup needed
- 39GB free on Pi
- Can backup easily

### Cons
- Slower (network storage)
- Need to fix Pi SSD issue first

### Steps

**1. Fix Pi SSD I/O errors**
```bash
./fix-pi-ssd-uas-quirks.sh
```

**Learning**: USB SSDs on Pi need special "quirks" to work reliably

**2. Verify Pi is accessible**
```bash
ls /home/flower/Obsidian-Pi/
```

Should show your mounted Samba share (already working!)

**3. Install VirtualBox on laptop**
```bash
sudo apt update
sudo apt install virtualbox virtualbox-ext-pack -y
```

**4. Create VM with disk on Pi**
```bash
# Set VM location to Pi share
VBoxManage createvm --name "TableauVM" \
  --ostype "Windows11_64" \
  --register \
  --basefolder "/home/flower/Obsidian-Pi/VMs"

# Create virtual hard disk on Pi
VBoxManage createhd \
  --filename "/home/flower/Obsidian-Pi/VMs/TableauVM/disk.vdi" \
  --size 51200

# Continue with VM setup...
```

See full script: `setup-vm-on-pi-storage.sh`

---

## Understanding VM Storage Over Network

### What happens:
```
┌──────────────────┐
│  Your Laptop     │
│  ┌──────────┐    │     Network      ┌─────────────┐
│  │VirtualBox│ ───┼─────────────────→│  Pi 5       │
│  │          │ ←──┼───────────────────│  SSD        │
│  │ (reads/  │    │     Samba        │  (stores    │
│  │  writes) │    │                  │   VM file)  │
│  └──────────┘    │                  └─────────────┘
└──────────────────┘
```

- **CPU & RAM**: Used on laptop (fast)
- **Disk I/O**: Goes over network to Pi (slower)
- **Speed**: Depends on your network (Tailscale over local WiFi = usually OK)

---

## Bash Learning: SSH Commands

### Command: `ssh user@host "command"`

**Example**:
```bash
ssh mini-monkey@raspberrypi "df -h"
```

**Breaking it down**:
- `ssh` = Secure Shell (remote terminal)
- `mini-monkey@raspberrypi` = username@hostname
- `"df -h"` = command to run on remote machine

**The quotes matter**:
```bash
# With quotes: runs df on Pi, shows Pi's disks
ssh mini-monkey@raspberrypi "df -h"

# Without quotes: tries to run "raspberrypi" and "df" separately (error!)
ssh mini-monkey raspberrypi df -h
```

### Command: `&&` (and operator)

**Example**:
```bash
command1 && command2
```

**What it does**:
- Run command1
- **Only if** command1 succeeds, run command2
- If command1 fails, stop (don't run command2)

**Real example**:
```bash
sudo apt update && sudo apt install virtualbox
```

Means: "Update package list, AND (if that worked) install virtualbox"

### Command: `||` (or operator)

**Example**:
```bash
command1 || command2
```

**What it does**:
- Run command1
- **Only if** command1 fails, run command2
- If command1 succeeds, skip command2

**Real example**:
```bash
docker system prune || echo "Docker not running"
```

Means: "Clean docker, OR (if that fails) print a message"

---

## Next Steps

1. **Choose your path** (A, B, or C)

2. **Run the appropriate scripts**:
   - Path A: `./check-m0nk-desktop.sh` then `./setup-tableau-vm-desktop.sh`
   - Path B: `./cleanup-laptop-space.sh` then follow VM setup
   - Path C: `./fix-pi-ssd-uas-quirks.sh` then `./setup-vm-on-pi-storage.sh`

3. **All scripts have comments** explaining what they do (for learning!)

---

## Files Created

- `device-comparison-and-setup.md` - Detailed device analysis
- `fix-pi-ssd-io-errors.sh` - Diagnose Pi SSD issues
- `fix-pi-ssd-uas-quirks.sh` - Fix common Pi + SanDisk problem
- `cleanup-laptop-space.sh` - Free up laptop disk space
- `TABLEAU-SETUP-GUIDE.md` - This file
- `immich-setup-commands.sh` - Immich server reference (from earlier)

---

## Questions?

**Q: Which path should I choose?**
A: Desktop (Path A) if specs are good. Otherwise Path C (Pi storage) to save laptop space.

**Q: Will VM be slow over network?**
A: For Tableau, depends on dataset size. Small datasets = fine. Large datasets = might be sluggish.

**Q: Can I move the VM later?**
A: Yes! VMs are just files. Can copy .vdi file anywhere.

**Q: Do I need Windows license?**
A: Windows will run without activation (with watermark). Can activate later if needed.

---

Let me know which path you want to take, and I'll help you through it!
