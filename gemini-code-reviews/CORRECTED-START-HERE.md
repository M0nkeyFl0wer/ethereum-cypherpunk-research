# ✅ CORRECTED SETUP - Start Here

**Apologies for earlier assumptions!** Here's the correct information from your actual setup.

---

## Your Devices (From Tailscale + SSH)

### Laptop (FlowerPowered)
- **CPU**: Intel i7-1165G7 (4 cores)
- **RAM**: 16GB (1.8GB available)
- **Disk**: 89GB total, **2.2GB free** ❌
- **Username**: flower
- **Status**: Too full for local VM

### Desktop (monk/m0nk) ⭐ BEST OPTION
- **CPU**: AMD Ryzen 5 2600 (6 cores) ✅ Better!
- **RAM**: 16GB (5GB available) ✅
- **System Disk**: 5.6GB free ⚠️
- **External SSD**: **445GB free** ✅ Perfect!
- **Username**: m0nkey-fl0wer
- **SSH**: `ssh monk` (already configured)
- **Location**: /media/m0nkey-fl0wer/Extreme_SSD

### Pi 5 (raspberrypi)
- **CPU**: ARM (4 cores)
- **RAM**: 8GB
- **Storage**: SanDisk SSD 39GB free (has I/O errors)
- **Username**: mini-monkey
- **SSH**: `ssh mini-monkey@raspberrypi`
- **Can't run Windows VM** (ARM processor)

---

## 🎯 Recommended: Use Desktop

Your desktop is **perfect** for Tableau VM:
- More powerful CPU (6 cores vs 4)
- Plenty of RAM (5GB available)
- External SSD with 445GB free space
- Already have SSH access configured

---

## Quick Setup (3 Commands)

### Step 1: Download Windows ISO (on laptop)
```bash
# Visit this URL in browser
firefox https://www.microsoft.com/software-download/windows11 &
```
Download the ISO to your Downloads folder.

### Step 2: Copy ISO to desktop
```bash
# After download completes
scp ~/Downloads/Win*.iso monk:/media/m0nkey-fl0wer/Extreme_SSD/
```

### Step 3: Run setup script (from laptop)
```bash
cd /home/flower/gemini-code-reviews
./setup-tableau-vm-on-desktop.sh
```

This script will:
- Check/install VirtualBox on desktop
- Create VM on the Extreme SSD (50GB)
- Configure 4 CPU cores, 4GB RAM
- Attach Windows ISO
- Enable remote access

---

## After Setup

### Start VM (from laptop):
```bash
ssh monk "VBoxManage startvm TableauVM --type headless"
```

**Learning**:
- `--type headless` = run without GUI (in background)
- You'll access it via remote desktop

### Access VM from laptop:
```bash
# Install RDP client if needed
sudo apt install remmina

# Connect
remmina -c rdp://monk:5001
```

Or use any RDP client pointing to: `monk:5001`

### Install Tableau (inside Windows VM):
Once Windows is installed, download Tableau:
- Visit: https://www.tableau.com/products/desktop/download
- Install inside the VM

---

## Why Desktop > Laptop > Pi

| Feature | Desktop (monk) | Laptop | Pi |
|---------|----------------|--------|-----|
| CPU Cores | 6 ✅ | 4 | 4 (ARM ❌) |
| Free Space | 445GB ✅ | 2.2GB ❌ | 39GB |
| Can Run Windows | Yes ✅ | Yes | No ❌ |
| Power Usage | Desktop power | Battery drain | Low power |
| Access | Via Tailscale ✅ | Local | Via Tailscale |

**Winner**: Desktop with external SSD

---

## Alternative: Clean Laptop + Use Pi for Storage

If you prefer to run on laptop (not recommended):

### Path 1: Clean laptop for local VM
```bash
./cleanup-laptop-space.sh  # Frees ~6-15GB
```
Still tight, but possible.

### Path 2: Use Pi SSD for VM storage
```bash
# Fix Pi SSD first
./fix-pi-ssd-uas-quirks.sh

# Then create VM on laptop, store on Pi
# (Slower due to network)
```

---

## Bash Learning: SSH to Desktop

### Your SSH config has this entry:
```bash
Host monk
    HostName 10.0.0.64
    User m0nkey-fl0wer
    ForwardAgent yes
```

**This means**:
```bash
ssh monk
# Is shorthand for:
ssh m0nkey-fl0wer@10.0.0.64
```

**Your SSH config** (`~/.ssh/config`) creates shortcuts!

### Running commands on desktop:
```bash
# Run single command
ssh monk "df -h"

# Run multiple commands
ssh monk "cd /tmp && ls -la"

# Interactive session
ssh monk
# Now you're "inside" the desktop
# Type commands, then 'exit' to return to laptop
```

---

## Files Created

- ✅ **setup-tableau-vm-on-desktop.sh** - Complete VM setup (USE THIS)
- `CORRECTED-START-HERE.md` - This file
- `device-comparison-and-setup.md` - Device analysis
- `cleanup-laptop-space.sh` - If you want to clean laptop
- `fix-pi-ssd-uas-quirks.sh` - If you want to fix Pi
- `bash-commands-reference.md` - Learning reference

---

## Questions?

**Q: Why did you assume usernames earlier?**
A: My mistake - I should have checked your SSH config and Tailscale first. Lesson learned!

**Q: Do I have to use the desktop?**
A: No, but it's the best option given your hardware. Laptop is too full, Pi can't run Windows.

**Q: Can I access the VM from anywhere?**
A: Yes! Via Tailscale, you can access monk:5001 from any device on your network.

**Q: How much does this cost?**
A: Free for everything except Tableau license (has free trial). Windows works unactivated.

---

## Ready to Start?

```bash
# 1. Download Windows ISO (in browser)
# 2. Copy to desktop:
scp ~/Downloads/Win*.iso monk:/media/m0nkey-fl0wer/Extreme_SSD/

# 3. Run setup:
./setup-tableau-vm-on-desktop.sh
```
