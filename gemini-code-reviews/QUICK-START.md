# Get Tableau Working TODAY

**Time estimate**: 1-2 hours total

---

## Step 1: Download Windows ISO (15-30 min)

Run this on your laptop RIGHT NOW:

```bash
cd ~/Downloads

# Download Windows 10 ISO (5.7GB)
wget -O windows10.iso "https://software-download.microsoft.com/pr/Win10_22H2_English_x64.iso"
```

This downloads in the background while we set up the VM.

**Alternative**: Visit https://www.microsoft.com/software-download/windows10 and download manually.

---

## Step 2: Copy ISO to Desktop (5 min)

Once download finishes:

```bash
# Copy to desktop (takes 2-5 minutes)
scp ~/Downloads/windows10.iso monk:/mnt/data/VirtualMachines/
```

---

## Step 3: Run Setup Script (5 min)

```bash
cd /home/flower/gemini-code-reviews

# Run the setup
./setup-tableau-TODAY.sh
```

This creates the VM and configures everything automatically.

---

## Step 4: Start VM (1 min)

```bash
# Start the VM
ssh monk "VBoxManage startvm TableauVM --type headless"
```

---

## Step 5: Connect & Install Windows (20-30 min)

```bash
# Install RDP client if you don't have it
sudo apt install remmina -y

# Connect to VM
remmina -c rdp://monk:5001
```

**In the VM window**:
1. Follow Windows installation prompts
2. Choose "I don't have a product key" (works fine)
3. Select "Windows 10/11 Home"
4. Wait for installation (~15-20 min)
5. Skip/decline all Microsoft account stuff (local account is fine)

---

## Step 6: Install Tableau (10 min)

**Inside Windows VM**:

1. Open Edge browser
2. Go to: https://www.tableau.com/products/desktop/download
3. Download Tableau Desktop
4. Install it (follow prompts)
5. Start Tableau!

---

## Step 7: Work!

You're done! Tableau is running.

**Access anytime from laptop**:
```bash
# Start VM if not running
ssh monk "VBoxManage startvm TableauVM --type headless"

# Connect
remmina -c rdp://monk:5001
```

**Access from phone**:
- Install "Microsoft Remote Desktop" app
- Connect to: `100.93.131.84:5001`

---

## Quick Commands

All commands saved in: `tableau-vm-commands.txt`

**Start VM**:
```bash
ssh monk "VBoxManage startvm TableauVM --type headless"
```

**Stop VM**:
```bash
ssh monk "VBoxManage controlvm TableauVM acpipowerbutton"
```

**Check if running**:
```bash
ssh monk "VBoxManage list runningvms"
```

---

## Troubleshooting

### Can't connect via RDP?
```bash
# Check VM is running
ssh monk "VBoxManage list runningvms"

# Should show: "TableauVM" ...
```

### VM won't start?
```bash
# Check for errors
ssh monk "VBoxManage showvminfo TableauVM | grep State"
```

### Windows installation stuck?
- Give it 5 more minutes
- Might be installing updates

### Need to start over?
```bash
# Delete VM and run setup again
ssh monk "VBoxManage unregistervm TableauVM --delete"
./setup-tableau-TODAY.sh
```

---

## Timeline

- **Now**: Start Windows ISO download
- **+30 min**: ISO downloaded, run setup script
- **+35 min**: Start VM, begin Windows install
- **+55 min**: Windows installed, install Tableau
- **+65 min**: Working in Tableau!

Total: ~1 hour (most is downloading/installing)

---

## After Today's Work

When you reinstall Ubuntu on desktop:
1. Timeshift will save the `/mnt/data` partition
2. VM will be there after reinstall
3. Just reinstall VirtualBox
4. VM works exactly as before

No need to reinstall Windows or Tableau!

---

Ready? Start the Windows download NOW:

```bash
cd ~/Downloads
wget -O windows10.iso "https://software-download.microsoft.com/pr/Win10_22H2_English_x64.iso"
```

While that downloads, read the rest of this guide!
