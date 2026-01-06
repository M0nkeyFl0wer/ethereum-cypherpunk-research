# Tableau: VM on Desktop vs Old MacBook Air

---

## TL;DR: Use Desktop VM (Much Better)

Your desktop's Ryzen 5 2600 (6 cores) will crush an old MacBook Air, even with VM overhead.

---

## Performance Comparison

### Old MacBook Air (2015-2017 era)
- **CPU**: Dual-core Intel Core i5 (~1.6-2.2GHz)
- **Cores**: 2 (maybe 4 with hyperthreading)
- **RAM**: Probably 4-8GB
- **Graphics**: Intel HD integrated
- **Performance**: ⭐⭐ (2/5)

### Desktop VM (Ryzen 5 2600)
- **CPU**: 6-core Ryzen @ 3.4GHz
- **VM allocation**: 4 cores, 4-6GB RAM
- **VM overhead**: ~10-20% performance loss
- **Effective power**: Still ~4x MacBook Air
- **Performance**: ⭐⭐⭐⭐ (4/5)

**Winner**: Desktop VM is **2-4x faster** than old MacBook Air

---

## Tableau-Specific Considerations

### What Tableau Needs
1. **CPU**: For calculations, data processing
2. **RAM**: For holding datasets in memory
3. **Disk I/O**: For loading data files
4. **Graphics**: For rendering visualizations

### VM Performance for Tableau

#### ✅ Great Performance
- CPU-bound tasks (filters, calculations)
- RAM usage (VM can have 4-6GB dedicated)
- Data loading from SSD (fast)

#### ⚠️ Good Performance (with setup)
- Graphics rendering
  - Need VirtualBox 3D acceleration enabled
  - Or GPU passthrough (advanced)
  - Still fine for most visualizations

#### ❌ Issues You Might Hit
- **Very complex dashboards** (100+ elements)
  - VM graphics might be slower
  - MacBook also struggles with this
  - Ryzen still wins due to CPU power

- **Huge datasets** (millions of rows)
  - Both need enough RAM
  - VM can allocate 6GB, MacBook Air probably has 8GB total
  - Ryzen wins: can dedicate more RAM

- **Real-time data refresh**
  - No VM impact
  - Network speed matters (Pi → Desktop)
  - Same for MacBook accessing Pi

---

## Real-World Tableau Workflow

### Scenario 1: Small to Medium Datasets (<100k rows)
**MacBook Air**: OK, usable
**Desktop VM**: Fast, smooth
**Winner**: Desktop VM (2x faster)

### Scenario 2: Large Datasets (100k-1M rows)
**MacBook Air**: Slow, might run out of RAM
**Desktop VM**: Good performance
**Winner**: Desktop VM (4x faster)

### Scenario 3: Complex Dashboards (10+ sheets)
**MacBook Air**: Laggy
**Desktop VM**: Smooth
**Winner**: Desktop VM

### Scenario 4: Data on Network (Pi's SSD)
**MacBook Air**: WiFi to Pi
**Desktop VM**: Gigabit ethernet to Pi (faster)
**Winner**: Desktop VM

---

## VM Overhead Breakdown

### What VM Loses (10-20% total)
- **Graphics**: 15-20% slower (3D rendering)
- **Disk I/O**: 5-10% slower (virtualization layer)
- **CPU**: 5% slower (hypervisor overhead)
- **RAM**: No loss (dedicated allocation)

### What VM Gains
- **Desktop has 3x more cores** than MacBook
- **Newer CPU architecture** (2018 vs 2015)
- **Better cooling** (desktop vs thin laptop)
- **More RAM to allocate**

**Net result**: Desktop VM is still **2-4x faster**

---

## Your Specific Desktop Advantages

### Just Discovered: Lots of Storage!
```
/dev/sdb1 - /mnt/data        647GB free  ✅
/dev/sdc1 - Extreme SSD      1.2TB free  ✅
/dev/sda1 - Extreme SSD      445GB free  ✅
```

**This changes everything!**
- Can put VM on fast local disk (/mnt/data)
- Extreme SSDs available for data
- No space constraints at all

### Updated Architecture
```
Desktop (monk):
  ├─ /mnt/data/VMs/TableauVM  (50GB VM - local, fast)
  ├─ Runs with 4-6 cores, 6GB RAM
  └─ Accesses data on Pi via network

Pi (raspberrypi):
  └─ Extreme SSD (moves here later)
      ├─ Tableau data files
      └─ Tableau outputs
```

---

## MacBook Air Issues

### Hardware Concerns
1. **Battery**: Probably degraded after 5-10 years
2. **Heat**: Thermal throttling when under load
3. **RAM**: Soldered, can't upgrade
4. **Storage**: Limited, can't expand
5. **Repairs**: Old parts, expensive

### Software Concerns
1. **macOS version**: Might not support latest Tableau
2. **Updates**: Apple drops support for old hardware
3. **Performance**: Gets slower over time

### Practical Concerns
1. **Always plugged in**: Battery degraded
2. **Fan noise**: Constantly running under load
3. **Desk space**: Needs to stay open and running
4. **Access**: Only from that physical machine

---

## Desktop VM Advantages

### Hardware
1. **Power**: Desktop components, better cooling
2. **Upgradeable**: Can add RAM, swap drives
3. **Reliable**: No battery to die
4. **Always on**: Server-like operation

### Software
1. **Windows**: Always supports latest Tableau
2. **Snapshots**: Save VM state before changes
3. **Backup**: Copy entire VM easily
4. **Reinstall**: Start fresh anytime

### Practical
1. **Remote access**: Use from laptop, phone, anywhere
2. **Multitask**: Desktop can run other VMs too
3. **No physical access needed**: Everything via SSH/RDP
4. **Centralized**: Fits your Pi server architecture

---

## Recommended Setup

### Use Desktop's /mnt/data (647GB free)

```bash
# Create VM on desktop's local fast storage
VM Location: /mnt/data/VMs/TableauVM (50GB)

# Mount Pi's SSD for data
Desktop mounts: Pi's Extreme SSD → /mnt/pi-data

# Tableau configuration:
- Reads data from: /mnt/pi-data/tableau-data/
- Saves output to: /mnt/pi-data/tableau-output/
```

**Benefits**:
- VM on fast local disk (647GB available)
- Data on Pi's SSD (centralized)
- When SSD moves to Pi, just remount it
- Nothing changes in your workflow

---

## VM Issues You Might Encounter (and Solutions)

### Issue 1: Graphics Lag
**Symptom**: Sluggish dashboard interactions
**Solution**: Enable 3D acceleration
```bash
VBoxManage modifyvm TableauVM --accelerate3d on --vram 128
```

### Issue 2: Slow Data Loading
**Symptom**: Long waits when opening files from Pi
**Solution**:
- Use NFS instead of Samba (faster)
- Cache frequently used data locally
- Upgrade to gigabit ethernet if not already

### Issue 3: VM Won't Start
**Symptom**: Error messages about virtualization
**Solution**: Enable VT-x in BIOS
```bash
# Check if enabled
egrep -c '(vmx|svm)' /proc/cpuinfo
# Should show > 0
```

### Issue 4: Not Enough RAM
**Symptom**: Windows slow in VM
**Solution**: Allocate more RAM
```bash
VBoxManage modifyvm TableauVM --memory 6144  # 6GB
```

### Issue 5: Network Storage Disconnects
**Symptom**: Lost connection to Pi's files
**Solution**: Use persistent NFS mounts with auto-reconnect
```bash
# In /etc/fstab with soft,retry options
```

---

## When MacBook Air Would Be Better

Honestly? Almost never for your use case.

**Only if**:
1. Desktop completely dies
2. You need to work offline (no Pi access)
3. You're traveling and need Tableau

**But even then**: Remote desktop into the desktop VM via Tailscale would work.

---

## Performance Expectations

### Desktop VM with Tableau
- **Small datasets** (< 10k rows): Instant, like native
- **Medium datasets** (10k-100k): < 2 seconds to load
- **Large datasets** (100k-1M): 5-15 seconds
- **Dashboard interactions**: Smooth, < 100ms
- **Exports/saves to Pi**: 1-3 seconds

### Old MacBook Air with Tableau
- **Small datasets**: OK, 2-3 seconds
- **Medium datasets**: Slow, 10-30 seconds
- **Large datasets**: Very slow or crashes
- **Dashboard interactions**: Laggy, 200-500ms
- **Exports**: Same as VM (network bound)

---

## Bash Learning: Checking Disk Performance

### Test disk speed
```bash
# Write test (measures write speed)
dd if=/dev/zero of=/mnt/data/testfile bs=1G count=1 oflag=direct

# Read test (measures read speed)
dd if=/mnt/data/testfile of=/dev/null bs=1G count=1 iflag=direct
```

**What this does**:
- `dd` = disk duplicator (copy data)
- `if` = input file
- `of` = output file
- `bs=1G` = block size of 1 gigabyte
- `oflag=direct` = bypass cache (real disk speed)

**Example output**:
```
1073741824 bytes (1.1 GB) copied, 2.5 s, 429 MB/s
```
This means: **429 MB/s** write speed

**Good speeds**:
- SSD: 400-550 MB/s (what you have)
- HDD: 100-150 MB/s
- Network (gigabit): 100-125 MB/s
- Network (Samba): 50-100 MB/s

---

## Decision Matrix

| Factor | Desktop VM | MacBook Air | Winner |
|--------|-----------|-------------|--------|
| CPU Power | 6 cores | 2 cores | Desktop (3x) |
| RAM | 6GB dedicated | 8GB total | Desktop |
| Storage | 647GB+ | 128-256GB | Desktop |
| Graphics | VM 3D | Intel HD | Desktop |
| Reliability | Server-grade | Aging battery | Desktop |
| Remote Access | Yes (RDP) | No | Desktop |
| Fits Architecture | Perfect | Separate | Desktop |
| Cost | $0 | $0 | Tie |
| Setup Time | 1 hour | Immediate | MacBook |

**Score**: Desktop VM wins 8/9 categories

---

## Final Recommendation

**Use Desktop VM** for these reasons:

1. **4x faster** than MacBook Air
2. **Fits your architecture** (Pi server, desktop compute)
3. **Plenty of space** (/mnt/data has 647GB)
4. **Access from anywhere** (RDP via Tailscale)
5. **Reliable** (no dying battery)
6. **Future-proof** (can upgrade desktop)

**Keep MacBook Air** as:
- Backup if desktop goes down
- Travel/offline work
- Other tasks (browsing, light work)

---

## Next Steps

1. Fix Pi SSD (for when it moves back):
   ```bash
   ./fix-pi-ssd-uas-quirks.sh
   ```

2. Create VM on desktop's /mnt/data:
   ```bash
   ./setup-tableau-vm-local-desktop.sh
   ```

3. Set up data folders on desktop's Extreme SSD (for now):
   ```bash
   ssh monk "mkdir -p /media/m0nkey-fl0wer/Extreme_SSD/{tableau-data,tableau-output}"
   ```

4. Later, when SSD moves to Pi:
   ```bash
   # Just mount Pi's SSD on desktop
   # Tableau points to same paths, no reconfiguration
   ```

Ready to create the setup script?
