# Device Comparison & Tableau VM Optimization Plan

**Date**: 2025-10-13
**Goal**: Optimize setup for running Tableau VM across your devices

---

## Your Tailscale Network Devices

| Device | Status | Type | Purpose |
|--------|--------|------|---------|
| **FlowerPowered** (100.121.226.39) | ✅ Active | Laptop | Current device |
| **raspberrypi** (100.75.223.48) | ✅ Active | Pi 5 | Home server |
| **m0nk** (100.93.131.84) | ✅ Active | Unknown | Desktop? |
| **creative-disruption2** (100.90.5.23) | ❌ Offline | PC | - |
| **oneplus-cph2551** (100.68.198.4) | ❌ Offline | Phone | Mobile |

---

## Device #1: FlowerPowered (Your Laptop)

### Specs
- **CPU**: Intel i7-1165G7 (4 cores, 8 threads @ 2.80GHz)
- **RAM**: 16GB (currently 1.8GB available)
- **Disk**: 89GB total, **2.2GB free** (98% used)
- **OS**: Linux

### Space Analysis
**Total Used**: 82GB

**Top Space Consumers**:
1. Projects: 15.5GB
   - Pintresting-content-engine: 7.2GB
   - Have-I-Been-Rekt: 4.1GB
   - qmk_firmware: 2.2GB
   - Others: 2GB

2. Cache & Local Data: 15.4GB ⚠️ **Easy to clean!**
   - ~/.local/share/pipx: 6.9GB (Python tools)
   - ~/.cache/pip: 4.1GB (Python package cache)
   - ~/.cache/puppeteer: 1.2GB (Browser automation)
   - ~/.cache/ms-playwright: 924MB (Browser testing)
   - ~/snap: 1.7GB (Snap packages)

3. Docker: 192MB (minimal)

**Potential Space Recovery**: ~15-20GB with safe cleanup

### Verdict for VM
- ❌ **Currently insufficient** (need 50GB+ for Windows VM)
- ✅ **Could work after cleanup** (would have ~17-22GB free)
- ⚠️ Still tight - would use 80-90% of disk after VM

---

## Device #2: Raspberry Pi 5 (raspberrypi)

### Specs
- **CPU**: ARM Cortex (4 cores)
- **RAM**: 8GB (6.3GB available)
- **Disk**:
  - SD Card: 14.8GB (system)
  - **SanDisk SSD**: 57GB total, **39GB free** ✅
- **OS**: Linux
- **Network**: Connected via Tailscale

### Current Status
- ⚠️ **SSD having I/O errors** (ghost-data mount issue)
- Already running: Immich, n8n
- **Samba share already configured**: //100.75.223.48/obsidian-sandisk

### Verdict for VM
- ❌ **Can't run Windows VM** (ARM processor, not x86)
- ✅ **Perfect for VM storage** (39GB free via Samba)
- ✅ **Already configured and working**

---

## Device #3: m0nk (Possible Desktop?)

### Status
- ✅ Connected to Tailscale
- ❓ Unknown specs (need SSH access)
- ❓ Could be your desktop machine

### Next Step
Need to investigate this device

---

## Understanding VM Options

### What does "running from" mean?

**Option A: Run VM on Laptop, Store on Laptop**
```
[Laptop CPU] → [Laptop RAM] → [Laptop Disk: VM file]
```
- Fast, but need 50GB local space
- Everything self-contained

**Option B: Run VM on Laptop, Store on Pi (Samba)**
```
[Laptop CPU] → [Laptop RAM] → [Network] → [Pi Disk: VM file]
```
- VM runs on laptop's CPU/RAM
- Disk file stored on Pi via network
- Performance depends on network speed
- Saves local disk space

**Option C: Run on Desktop (if m0nk is desktop)**
```
[Desktop CPU] → [Desktop RAM] → [Desktop/Pi Disk]
```
- Need to check desktop specs first

---

## Recommended Setup Options

### Option 1: Clean Laptop + Local VM (Best Performance)

**Pros**:
- Fastest performance
- No network dependency
- Full control

**Cons**:
- Need to clean ~15GB of cache
- Laptop disk still tight after

**Steps**:
1. Clean caches (free ~15GB)
2. Install VirtualBox/KVM
3. Create 50GB VM on laptop
4. Install Windows + Tableau

**Commands**: See `cleanup-laptop.sh`

---

### Option 2: Laptop VM + Pi Storage (Balanced) ⭐ RECOMMENDED

**Pros**:
- No laptop cleanup needed
- 39GB free on Pi (plenty of space)
- Samba already configured
- Keep laptop space for other work

**Cons**:
- Slower disk I/O (network speed dependent)
- Need to fix Pi SSD issue first
- VMs over network can be sluggish

**Steps**:
1. Fix Pi SSD I/O issue (see `fix-pi-ssd.sh`)
2. Install VirtualBox on laptop
3. Store VM file on /home/flower/Obsidian-Pi/ (already mounted)
4. Run VM from laptop

**Why This is Best**:
- Your Samba is already working (39GB free)
- Keeps laptop disk clean
- Can easily backup VM on Pi
- Tailscale means access from anywhere

---

### Option 3: Check m0nk Desktop

If m0nk is a desktop with better specs, might be best option.

**Steps**: See `check-m0nk-device.sh`

---

## Python Learning: Understanding Disk Space

### Command: `du -sh`
```bash
du -sh ~/.cache
# Output: 6.8G    /home/flower/.cache
```

**Breaking it down**:
- `du` = "**d**isk **u**sage" - measures how much space files use
- `-s` = "**s**ummary" - show total only, don't list each file
- `-h` = "**h**uman readable" - show 6.8G instead of 7000000000

**Why use it**: Quick way to see directory sizes

### Command: `sort -hr`
```bash
du -sh ~/* | sort -hr
```

**Breaking it down**:
- `|` = "pipe" - sends output from left command to right command
- `sort` = organize lines
- `-h` = sort by **h**uman numbers (understands 6.8G > 1.2G)
- `-r` = **r**everse (largest first)

**Example**:
```bash
# Without -h, sort doesn't understand sizes:
# 924M would come before 1.2G (wrong!)

# With -h, sort knows:
# 6.9G > 4.1G > 1.2G > 924M (correct!)
```

### Command: `find`
```bash
find ~ -name "node_modules" -type d
```

**Breaking it down**:
- `find` = search for files/folders
- `~` = start searching in home directory
- `-name "node_modules"` = only match things named "node_modules"
- `-type d` = only match **d**irectories (not files)

**Why**: node_modules can be huge (1GB+) but easy to recreate

---

## Next Steps

1. **Choose your option** (I recommend Option 2)
2. **If Option 1**: Run `./cleanup-laptop.sh`
3. **If Option 2**: Run `./fix-pi-ssd.sh` then `./setup-vm-on-pi-storage.sh`
4. **If Option 3**: Run `./check-m0nk-device.sh` first

All scripts created with explanations for learning!
