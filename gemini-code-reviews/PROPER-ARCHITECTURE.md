# Proper Architecture for Tableau Setup

**Your Vision**: Desktop runs Tableau, Pi serves files, access from anywhere

---

## The Right Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Your Network                         │
│                                                          │
│  ┌──────────────┐         ┌──────────────┐             │
│  │   Pi 5       │◄────────│  Desktop     │             │
│  │ (Server)     │  Samba  │  (monk)      │             │
│  │              │         │              │             │
│  │ - File       │         │ - Windows VM │             │
│  │   Storage    │         │ - Tableau    │             │
│  │ - Extreme    │         │ - 6-core CPU │             │
│  │   SSD        │         │              │             │
│  │   (445GB)    │         │ Reads/Writes │             │
│  │              │         │ to Pi SSD ───┤             │
│  └──────────────┘         └──────┬───────┘             │
│                                   │                     │
│                                   │ RDP                 │
│                            ┌──────▼───────┐            │
│                            │   Laptop     │            │
│                            │ (or phone)   │            │
│                            │              │            │
│                            │ Access       │            │
│                            │ Tableau      │            │
│                            │ Remotely     │            │
│                            └──────────────┘            │
│                                                         │
│              All connected via Tailscale                │
└─────────────────────────────────────────────────────────┘
```

---

## How It Works

### Desktop (monk)
**Role**: Compute powerhouse
- Runs Windows VM (or Windows directly)
- Tableau installed inside
- Uses its 6-core CPU for processing
- VM stored on desktop's internal disk (5.6GB available - tight but doable)
- **Connects to Pi's SSD via Samba for data**

### Pi 5 (raspberrypi)
**Role**: File & program server
- Hosts the Extreme SSD (445GB) via Samba
- Stores:
  - Tableau data files (.csv, .xlsx, databases)
  - Tableau output files (.twbx, .pdf, images)
  - Your programs and shared files
- Always on, accessible from anywhere

### Laptop (FlowerPowered)
**Role**: Remote access device
- RDP into desktop to use Tableau
- Lightweight - just displaying the desktop's screen
- Could also be phone, tablet, another laptop

---

## Storage Layout

### Desktop Internal Disk (114GB, 5.6GB free)
```
/media/m0nkey-fl0wer/
  └── (mount Pi's Samba share here)
       └── Extreme_SSD/
           ├── tableau-data/      (data files)
           ├── tableau-output/    (saved workbooks)
           └── shared-programs/   (other files)
```

**VM Location**: Desktop's internal disk
- Smaller VM (30GB instead of 50GB to fit)
- Just Windows + Tableau
- Data lives on Pi, not in VM

### Pi's SSD (445GB free)
```
/media/sandisk/
  ├── tableau-data/          (input: CSVs, databases)
  ├── tableau-output/        (output: workbooks, dashboards)
  ├── shared-programs/       (your other files)
  ├── immich/               (already there)
  ├── obsidian-vault/       (already there)
  └── n8n-data/            (already there)
```

---

## Why This is Better

### ✅ Advantages
1. **SSD stays on Pi** - proper file server
2. **Desktop does compute** - uses 6-core CPU
3. **Access from anywhere** - RDP via Tailscale
4. **Centralized data** - all files on Pi
5. **Easy backups** - everything on Pi's SSD
6. **Phone access** - RDP apps for mobile

### ❌ Your Current Desktop Limitation
- Only 5.6GB free on internal disk
- Not enough for 50GB VM
- **Solution**: Create smaller 25-30GB VM (just OS + Tableau)

---

## Two Implementation Options

### Option A: Small VM on Desktop ⭐ RECOMMENDED

**VM Size**: 25-30GB (fits in 5.6GB free? No...)
**Issue**: Still need ~30GB free for VM

**Check if desktop has space elsewhere:**
```bash
ssh monk "df -h"
```

Maybe there's another partition?

### Option B: VM on Pi, Run from Desktop (Hybrid)

**VM Location**: Pi's Extreme SSD (445GB free)
**Runs on**: Desktop CPU via network
**Performance**: Slightly slower disk I/O, but works

This way:
- VM file is on Pi (plenty of space)
- VM runs using desktop's CPU/RAM
- Tableau data also on Pi
- Everything centralized

---

## Recommended Setup: Hybrid Approach

Since desktop only has 5.6GB free, use the Pi's SSD for the VM too:

```
Desktop (monk):
  - VirtualBox installed
  - Mounts Pi's SSD via Samba/NFS
  - Runs VM from Pi's SSD
  - Uses desktop's 6-core CPU and RAM
  - Tableau data also on Pi's SSD

Pi (raspberrypi):
  - Extreme SSD connected
  - Shared via Samba/NFS
  - Stores:
    * Windows VM file (30GB)
    * Tableau data
    * Tableau outputs
    * Other shared files
```

**Access flow:**
1. From laptop: `ssh monk "VBoxManage startvm TableauVM"`
2. From laptop: RDP to `monk:5001`
3. In Windows: Tableau opens, reads/writes to `Z:\tableau-data\` (Pi's SSD)
4. Close RDP, Tableau keeps running on desktop
5. Reconnect anytime from any device

---

## Performance Considerations

### Fast (Local disk on desktop)
- ✅ VM boot time
- ✅ Windows responsiveness
- ❌ Don't have space for this

### Good (VM on Pi via network, runs on desktop)
- ⚠️ Slightly slower VM boot
- ✅ Tableau runs fast (uses desktop CPU)
- ✅ Data I/O acceptable (gigabit network)
- ✅ Centralizes everything
- ✅ Works with your setup

### Comparison
- **VM on Pi, CPU on Desktop**: ~90% performance of local
- **VM on laptop**: Would be 100% but no space
- **VM on Pi, CPU on Pi**: Would be 30% (ARM can't run Windows)

---

## Python Learning: Understanding Network Storage

### Samba/SMB (What you already use)
```bash
# Your existing Obsidian mount
//100.75.223.48/obsidian-sandisk mounted at /home/flower/Obsidian-Pi
```

**What is Samba?**
- Windows-style file sharing for Linux
- Shows up as network drive
- Good for: Documents, data files
- Speed: Good for file access, slower for VM disks

### NFS (Better for VMs)
**What is NFS?**
- Linux-native file sharing
- Faster than Samba for large files
- Better for: VM disk files
- Speed: ~90% of local disk

### Which to use?
- **Tableau data/output**: Samba (easier, already working)
- **VM disk file**: NFS (faster for VMs)
- Can use both simultaneously

---

## Bash Learning: Mounting Network Storage

### Check what's already mounted
```bash
mount | grep cifs
# Shows: //100.75.223.48/obsidian-sandisk on /home/flower/Obsidian-Pi
```

**Breaking it down:**
- `mount` = show all mounted filesystems
- `|` = pipe output to next command
- `grep cifs` = filter for CIFS/Samba mounts

### Mount Samba share (what you already have)
```bash
mount -t cifs //SERVER/share /mount/point -o username=USER
```

**Example** (what's probably in your /etc/fstab):
```bash
//100.75.223.48/obsidian-sandisk /home/flower/Obsidian-Pi cifs credentials=/home/flower/.smbcredentials
```

### Mount NFS share (better for VMs)
```bash
# On Pi, share via NFS
sudo apt install nfs-kernel-server
echo "/media/sandisk *(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
sudo exportfs -a

# On desktop, mount via NFS
sudo apt install nfs-common
sudo mount -t nfs 100.75.223.48:/media/sandisk /mnt/pi-ssd
```

**What this does:**
- Pi exports `/media/sandisk` via NFS
- Desktop mounts it at `/mnt/pi-ssd`
- VirtualBox can use files on `/mnt/pi-ssd` faster than Samba

---

## Recommended Implementation Plan

### Phase 1: Set up NFS (better for VM)
```bash
# Fix Pi SSD first
./fix-pi-ssd-uas-quirks.sh

# Set up NFS on Pi
./setup-pi-nfs-share.sh

# Mount on desktop
./mount-pi-on-desktop.sh
```

### Phase 2: Create VM on Pi's SSD
```bash
# Create VM, store on Pi
./setup-tableau-vm-hybrid.sh
```

**This script will:**
1. Mount Pi's SSD on desktop via NFS
2. Create 30GB VM on Pi's SSD
3. Configure VM to use desktop's CPU/RAM
4. Set up data folders on Pi
5. Enable RDP access

### Phase 3: Install Windows + Tableau
```bash
# Start VM
ssh monk "VBoxManage startvm TableauVM --type headless"

# Connect via RDP
remmina -c rdp://monk:5001

# Inside Windows:
# 1. Map network drive: Z: → \\100.75.223.48\sandisk
# 2. Install Tableau
# 3. Point Tableau to Z:\tableau-data\
```

### Phase 4: Use from anywhere
```bash
# From laptop
rdesktop monk:5001

# From phone
# Install Microsoft Remote Desktop app
# Connect to: monk:5001 (via Tailscale)
```

---

## Next Steps

1. **Decide on approach:**
   - Small VM on desktop internal disk? (need to find space)
   - VM on Pi's SSD via NFS? (recommended given space constraints)

2. **Fix Pi SSD first** (still has I/O errors):
   ```bash
   ./fix-pi-ssd-uas-quirks.sh
   ```

3. **Set up proper shares:**
   ```bash
   # I'll create these scripts:
   ./setup-pi-nfs-share.sh      (for VM disk)
   ./setup-pi-samba-folders.sh   (for Tableau data)
   ```

4. **Create VM in right location**:
   ```bash
   ./setup-tableau-vm-hybrid.sh
   ```

Would you like me to create the scripts for the hybrid approach (VM on Pi, runs on desktop)?
