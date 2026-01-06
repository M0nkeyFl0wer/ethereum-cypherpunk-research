# Bash Commands Reference for Tableau VM Setup

**Date**: 2025-10-13
**Purpose**: Quick reference for all commands used in this project

---

## Table of Contents

1. [Disk Space Commands](#disk-space-commands)
2. [SSH Commands](#ssh-commands)
3. [File Operations](#file-operations)
4. [VM Setup Commands](#vm-setup-commands)
5. [Network Commands](#network-commands)
6. [System Information](#system-information)
7. [Learning: Understanding Operators](#learning-understanding-operators)

---

## Disk Space Commands

### Check disk usage
```bash
df -h
```
**What it does**: Shows disk space on all mounted drives
- `df` = disk free
- `-h` = human readable (GB not bytes)

### Check directory sizes
```bash
du -sh ~/Downloads
```
**What it does**: Shows size of a specific directory
- `du` = disk usage
- `-s` = summary (total only)
- `-h` = human readable

### Find largest directories
```bash
du -sh ~/* | sort -hr | head -10
```
**What it does**: Lists top 10 largest directories in home
- `|` = pipe (send output to next command)
- `sort -hr` = sort by size, largest first
- `head -10` = show first 10 lines

### Find large files
```bash
find ~ -type f -size +1G
```
**What it does**: Find files larger than 1GB
- `find` = search for files
- `-type f` = files only (not directories)
- `-size +1G` = bigger than 1 gigabyte

---

## SSH Commands

### Connect to remote machine
```bash
ssh username@hostname
```
**Example**:
```bash
ssh mini-monkey@raspberrypi
```

### Run command on remote machine
```bash
ssh username@hostname "command"
```
**Example**:
```bash
ssh mini-monkey@raspberrypi "df -h"
```

### Copy file to remote machine
```bash
scp /local/file username@hostname:/remote/path
```

### Copy file from remote machine
```bash
scp username@hostname:/remote/file /local/path
```

---

## File Operations

### List files
```bash
ls -la
```
**What it does**: List all files with details
- `-l` = long format (shows permissions, size, date)
- `-a` = all files (including hidden ones starting with .)

### Create directory
```bash
mkdir my-folder
```

### Remove file
```bash
rm filename
```

### Remove directory and contents
```bash
rm -rf directory
```
**Warning**: `-rf` = recursive + force (no undo!)

### Check file contents
```bash
cat filename
```

### Check first 10 lines
```bash
head -10 filename
```

### Check last 10 lines
```bash
tail -10 filename
```

---

## VM Setup Commands

### Install VirtualBox
```bash
sudo apt update && sudo apt install virtualbox virtualbox-ext-pack -y
```
**Breaking it down**:
- `sudo` = run as administrator
- `apt update` = refresh package list
- `&&` = and then (only if first succeeds)
- `apt install` = install software
- `-y` = automatically say yes

### Create VM (command line)
```bash
VBoxManage createvm --name "TableauVM" --ostype "Windows11_64" --register
```

### Create virtual hard disk
```bash
VBoxManage createhd --filename "disk.vdi" --size 51200
```
**Note**: Size is in MB (51200 MB = 50 GB)

### Start VM
```bash
VBoxManage startvm "TableauVM"
```

### List all VMs
```bash
VBoxManage list vms
```

---

## Network Commands

### Check Tailscale status
```bash
tailscale status
```
**What it does**: Shows all devices on your Tailscale network

### Test connection to remote host
```bash
ping -c 4 hostname
```
**What it does**: Send 4 test packets
- `-c 4` = count of 4 pings

### Check open ports
```bash
netstat -tlnp | grep 2283
```
**What it does**: See if port 2283 is listening
- `-t` = TCP connections
- `-l` = listening ports
- `-n` = show numbers not names
- `-p` = show program name

### Test if port is open
```bash
curl http://100.75.223.48:2283
```

---

## System Information

### Check CPU info
```bash
grep "model name" /proc/cpuinfo | head -1
```

### Check RAM
```bash
free -h
```
**Output explained**:
- `total` = total RAM installed
- `used` = currently in use
- `free` = completely unused
- `available` = free + reclaimable (this is what matters!)

### Check CPU cores
```bash
grep "cpu cores" /proc/cpuinfo | head -1
```

### Check if system supports virtualization
```bash
egrep -c '(vmx|svm)' /proc/cpuinfo
```
**What it does**: Counts CPU flags for virtualization
- `vmx` = Intel virtualization
- `svm` = AMD virtualization
- If output > 0, virtualization supported

### Check current user
```bash
whoami
```

### Check current directory
```bash
pwd
```
**What it does**: Print working directory

---

## Learning: Understanding Operators

### The Pipe: `|`
```bash
command1 | command2
```
**What it does**: Sends output of command1 into command2

**Example**:
```bash
ls -la | grep "txt"
# List files, then filter for only .txt files
```

### AND operator: `&&`
```bash
command1 && command2
```
**What it does**: Run command2 ONLY if command1 succeeds

**Example**:
```bash
cd /tmp && ls
# Change directory, and if successful, list files
# If cd fails, ls won't run
```

### OR operator: `||`
```bash
command1 || command2
```
**What it does**: Run command2 ONLY if command1 fails

**Example**:
```bash
docker ps || echo "Docker not running"
# Try to list containers, or if that fails, print message
```

### Semicolon: `;`
```bash
command1 ; command2
```
**What it does**: Run both commands, regardless of success/failure

**Example**:
```bash
cd /nonexistent ; ls
# Try to cd (fails), but still run ls (shows current directory)
```

### Redirect output: `>`
```bash
command > file
```
**What it does**: Save command output to file (overwrites)

**Example**:
```bash
ls -la > filelist.txt
# Save file listing to a text file
```

### Append output: `>>`
```bash
command >> file
```
**What it does**: Add command output to end of file

**Example**:
```bash
echo "New line" >> log.txt
# Add a line to existing log file
```

### Suppress errors: `2>/dev/null`
```bash
command 2>/dev/null
```
**What it does**: Hide error messages

**Example**:
```bash
ls /root 2>/dev/null
# Try to list /root, hide "Permission denied" error
```

---

## Quick Cleanup Commands

### Clean pip cache
```bash
pip cache purge
```
**Recovers**: ~4GB
**Safe**: Yes, can redownload packages

### Clean npm cache
```bash
npm cache clean --force
```

### Clean Docker
```bash
docker system prune -a -f
```
**Recovers**: Varies
**Safe**: Yes, removes unused images

### Empty trash
```bash
rm -rf ~/.local/share/Trash/*
```

### Clean browser caches
```bash
rm -rf ~/.cache/puppeteer
rm -rf ~/.cache/ms-playwright
```

---

## SanDisk SSD + Pi Fix

### Check USB device ID
```bash
lsusb | grep -i sandisk
```

### Apply USB quirks
```bash
echo "options usb-storage quirks=XXXX:XXXX:u" | \
  sudo tee /etc/modprobe.d/usb-storage-quirks.conf
sudo update-initramfs -u
sudo reboot
```
**Replace**: XXXX:XXXX with your device ID from lsusb

---

## Common Patterns

### Check if command exists
```bash
which virtualbox
```
**Output**: Path if exists, nothing if doesn't exist

### Run command as root
```bash
sudo command
```

### See command history
```bash
history
```

### Repeat last command
```bash
!!
```

### Repeat last command with sudo
```bash
sudo !!
```

---

## Troubleshooting Commands

### Check system logs
```bash
dmesg | tail -50
```
**What it does**: Shows last 50 kernel messages

### Check for errors in logs
```bash
dmesg | grep -i error
```

### Check service status
```bash
sudo systemctl status docker
```

### Restart service
```bash
sudo systemctl restart docker
```

### Check what's using a port
```bash
sudo lsof -i :2283
```

### Check running processes
```bash
ps aux | grep virtualbox
```

---

## Pro Tips

### 1. Tab completion
Press `Tab` while typing to auto-complete
```bash
cd /home/flo<TAB>  → cd /home/flower/
```

### 2. Ctrl+R for history search
Press `Ctrl+R`, then type part of a command you ran before

### 3. Use `man` for help
```bash
man ls
# Shows manual for ls command
```

### 4. Use `--help` for quick help
```bash
ls --help
```

### 5. Multiple commands on one line
```bash
cd /tmp && ls -la && pwd
```

---

## All Scripts Created

1. `device-comparison-and-setup.md` - Device analysis
2. `fix-pi-ssd-io-errors.sh` - Diagnose Pi SSD
3. `fix-pi-ssd-uas-quirks.sh` - Fix Pi SSD (THE FIX)
4. `cleanup-laptop-space.sh` - Free laptop space
5. `check-m0nk-desktop.sh` - Check desktop specs
6. `TABLEAU-SETUP-GUIDE.md` - Complete setup guide
7. `bash-commands-reference.md` - This file!

---

**Remember**: All scripts have comments explaining what they do. Read them to learn!
