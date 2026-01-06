# 🚀 START HERE - Simple Steps

**You are here**: Laptop (FlowerPowered)
**Stay here**: Run all commands from this laptop

---

## Step 1: Check Desktop Specs

**Run this command** (on laptop):
```bash
cd /home/flower/gemini-code-reviews
./check-m0nk-desktop.sh
```

**What it does**: Connects to your desktop (m0nk) via SSH and checks if it's good for Tableau VM

**Possible outcomes**:

### ✅ If it works:
You'll see desktop specs (CPU, RAM, disk space)
→ **Go to Step 2**

### ❌ If you get "Permission denied" or "Host key verification failed":
Desktop SSH not set up yet

**Quick fix**:
```bash
# Try connecting manually first
ssh m0nk

# If that doesn't work, try with IP
ssh 100.93.131.84
```

**Don't know username?** Try these common ones:
- `ssh flower@m0nk`
- `ssh ben@m0nk`
- `ssh mini-monkey@m0nk`

Once you find the right one, the script will work.

---

## Step 2: Decide Based on Desktop

### If Desktop has 50GB+ free space and 8GB+ RAM:
**Best option!** Use desktop for Tableau VM
→ **Read**: `TABLEAU-SETUP-GUIDE.md` → Path A

### If Desktop doesn't have enough space:
**Choose**:
- Clean laptop and run VM locally → Path B
- Use Pi storage for VM → Path C (but fix Pi first)

→ **Read**: `TABLEAU-SETUP-GUIDE.md` for full options

---

## Step 3: Fix Pi SSD (if using Pi storage)

**Only if** you chose Path C (Pi storage)

**Run this** (on laptop):
```bash
./fix-pi-ssd-uas-quirks.sh
```

**What it does**: Fixes common SanDisk + Pi 5 USB errors via SSH

**Takes**: 5 minutes + Pi reboot

---

## Step 4: Clean Laptop (if needed)

**Only if** you chose Path B (local VM)

**Run this** (on laptop):
```bash
./cleanup-laptop-space.sh
```

**What it does**: Safely removes caches to free 6-15GB

**Takes**: 2-3 minutes

---

## All Commands Run From Laptop

**Remember**: Stay on your laptop for all scripts

```
You (on laptop)
    │
    ├─→ ./check-m0nk-desktop.sh  (checks desktop via SSH)
    ├─→ ./fix-pi-ssd-uas-quirks.sh  (fixes Pi via SSH)
    └─→ ./cleanup-laptop-space.sh  (cleans laptop locally)
```

---

## Files for Reference

- **`WHERE-TO-RUN-SCRIPTS.md`** - Detailed explanation of where to run what
- **`TABLEAU-SETUP-GUIDE.md`** - Complete setup guide with paths A/B/C
- **`bash-commands-reference.md`** - Learn all the bash commands
- **`device-comparison-and-setup.md`** - Device analysis

---

## Questions?

**Q: Do I need to be on the Pi or desktop?**
A: No! Stay on laptop. Scripts use SSH to connect remotely.

**Q: What if SSH doesn't work?**
A: Read `WHERE-TO-RUN-SCRIPTS.md` for SSH troubleshooting.

**Q: Which path should I choose?**
A: Desktop (Path A) if it has space, otherwise Pi storage (Path C).

---

**Ready?** Run the first command:
```bash
cd /home/flower/gemini-code-reviews
./check-m0nk-desktop.sh
```
