#!/bin/bash
# Clean Up Laptop Disk Space
# Safe cleanup of caches and temporary files

echo "=== Laptop Disk Space Cleanup ==="
echo ""
echo "Current disk usage:"
df -h / | tail -1
echo ""
echo "This will clean:"
echo "  - Python pip cache (~4.1GB)"
echo "  - Puppeteer cache (~1.2GB)"
echo "  - Playwright cache (~924MB)"
echo "  - Trash (~168MB)"
echo "  - Docker images (~192MB)"
echo ""
echo "Total recovery: ~6.5GB (safe to delete)"
echo ""
read -p "Continue? (y/n): " CONTINUE

if [ "$CONTINUE" != "y" ]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo "STEP 1: Cleaning pip cache..."
echo "Command: pip cache purge"
echo "What it does: Removes downloaded Python packages (can re-download if needed)"
echo ""
pip cache purge

echo ""
echo "STEP 2: Cleaning Puppeteer cache..."
echo "Command: rm -rf ~/.cache/puppeteer"
echo "What it does: Removes browser binaries for automation (can reinstall if needed)"
echo ""
rm -rf ~/.cache/puppeteer

echo ""
echo "STEP 3: Cleaning Playwright cache..."
echo "Command: rm -rf ~/.cache/ms-playwright"
echo "What it does: Removes browser binaries for testing (can reinstall if needed)"
echo ""
rm -rf ~/.cache/ms-playwright

echo ""
echo "STEP 4: Emptying trash..."
echo "Command: rm -rf ~/.local/share/Trash/*"
echo "What it does: Permanently deletes trashed files"
echo ""
rm -rf ~/.local/share/Trash/*

echo ""
echo "STEP 5: Cleaning Docker..."
echo "Command: docker system prune -a -f"
echo "What it does: Removes unused Docker images and containers"
echo ""
docker system prune -a -f 2>/dev/null || echo "Docker not running, skipped"

echo ""
echo "=== Optional: Deep Clean ==="
echo ""
echo "These are larger but might be needed. Check first!"
echo ""
echo "Optional 1: Clean ALL pipx tools (6.9GB)"
echo "  Command: rm -rf ~/.local/share/pipx"
echo "  Warning: Will need to reinstall Python CLI tools"
echo ""
echo "Optional 2: Clean old snap revisions (1.7GB possible)"
echo "  Command: sudo snap list --all | awk '/disabled/{print \$1, \$3}' | while read name rev; do sudo snap remove \"\$name\" --revision=\"\$rev\"; done"
echo "  Warning: Keeps current versions only"
echo ""
read -p "Run optional cleanups? (y/n): " OPTIONAL

if [ "$OPTIONAL" = "y" ]; then
    echo ""
    echo "Cleaning old snap revisions..."
    sudo snap list --all | awk '/disabled/{print $1, $3}' | while read name rev; do
        echo "Removing snap: $name revision $rev"
        sudo snap remove "$name" --revision="$rev"
    done
fi

echo ""
echo "=== Cleanup Complete ==="
echo ""
echo "New disk usage:"
df -h / | tail -1
echo ""
echo "Space freed:"
echo "Before: 82G used, 2.2G free"
df -h / | tail -1 | awk '{print "After: " $3 " used, " $4 " free"}'
echo ""
