# Tableau VM Setup Guide

**Date**: 2025-10-13
**Goal**: Get Tableau running in a virtual machine

---

## Your Current System

- **CPU**: Intel i7-1165G7 (4 cores, 8 threads) ✅ Good for VM
- **RAM**: 16GB total (1.8GB currently available) ⚠️ Tight but workable
- **Disk**: 89GB total, **only 2.2GB free** ❌ **CRITICAL ISSUE**

**Problem**: Tableau needs 40-60GB for a Windows VM. You don't have enough space.

---

## Understanding The Problem

### What is a VM?
A **Virtual Machine (VM)** is like running a computer inside your computer. It needs:
- Disk space for the "virtual hard drive"
- RAM to run
- CPU cores to process

### Why Tableau needs a VM
- Tableau Desktop only runs on Windows or macOS
- You're on Linux, so you need a Windows VM
- Windows alone needs ~20GB + Tableau needs ~10-20GB = 40-60GB total

---

## Your Options

### Option 1: Free Up Disk Space (Recommended if you want local VM)
**What**: Clean up your current machine to make room
**Pros**: Run Tableau locally, fast performance
**Cons**: Need to delete ~40-50GB of files

See: `check-disk-usage.sh` for commands

### Option 2: Use Pi for Storage (Hybrid approach)
**What**: Store VM disk file on Pi's SanDisk, run VM on laptop
**Pros**: Don't need to delete local files
**Cons**: Performance depends on network speed, requires setup

### Option 3: Tableau Public (No VM needed)
**What**: Free web-based version of Tableau
**Pros**: No VM needed, no disk space issues, free
**Cons**: Limited features, data is public, requires internet

Website: https://public.tableau.com

### Option 4: Cloud VM
**What**: Run Windows VM in the cloud (AWS, Azure, Google Cloud)
**Pros**: No local resources needed
**Cons**: Costs money, requires internet

---

## Next Steps - Choose Your Path

Run these commands to decide:

```bash
# See what's using your disk space
./check-disk-usage.sh

# After reviewing, choose:
# Path A: Free up local space → follow local-vm-setup.sh
# Path B: Use Pi storage → follow pi-storage-vm-setup.sh
# Path C: Try Tableau Public (no VM) → just use web browser
```

---

## Learning Notes

### Bash Command: `df -h`
**What it does**: Shows disk space usage
- `df` = "disk free"
- `-h` = "human readable" (shows GB instead of bytes)

### Bash Command: `du -sh`
**What it does**: Shows directory size
- `du` = "disk usage"
- `-s` = "summary" (total size)
- `-h` = "human readable"

### Why use the pipe `|`
```bash
command1 | command2
```
The `|` (pipe) sends output from command1 into command2
Example: `ls -la | grep file` means "list files, then search for 'file'"
