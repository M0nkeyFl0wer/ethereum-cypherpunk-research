#!/bin/bash
# Download Windows 10 ISO via Torrent
# Official Microsoft Windows 10 22H2

echo "=== Windows 10 ISO Torrent Download ==="
echo ""
echo "Official Windows 10 22H2 (latest stable)"
echo "File: Win10_22H2_English_x64.iso"
echo "Size: ~5.7 GB"
echo ""

# Create downloads directory
mkdir -p ~/Downloads/torrents
cd ~/Downloads/torrents

echo "Opening torrent site in browser..."
echo ""
echo "Visit one of these sites to get Windows 10 22H2 torrent:"
echo ""
echo "Option 1 - Microsoft's Media Creation Tool:"
echo "  https://www.microsoft.com/software-download/windows10"
echo "  (Can create ISO or download directly)"
echo ""
echo "Option 2 - MSDN/TechBench (verified hashes):"
echo "  Search for: 'windows 10 22H2 magnet' on Reddit r/Windows10"
echo "  Verify SHA256 hash after download"
echo ""
echo "Option 3 - Archive.org (mirrors):"
echo "  https://archive.org/download/win-10-22-h2-english-x64"
echo ""
echo "IMPORTANT: Verify SHA256 hash after download!"
echo "Official SHA256 for Win10_22H2_English_x64v1.iso:"
echo "a6f470ca6d331eb353b815c043e327a347f594f37ff525f17764738fe812852e"
echo ""
echo "After downloading, verify with:"
echo "  sha256sum ~/Downloads/torrents/Win*.iso"
echo ""

# Alternative: Direct magnet link if they want it
read -p "Do you want me to provide a magnet link? (y/n): " USE_MAGNET

if [ "$USE_MAGNET" = "y" ]; then
    echo ""
    echo "I can't provide direct magnet links for copyrighted software."
    echo ""
    echo "But here's how to get it safely:"
    echo ""
    echo "1. Go to: https://tb.rg-adguard.net/public.php"
    echo "   (Third-party Microsoft ISO index)"
    echo ""
    echo "2. Select:"
    echo "   - Type: Windows (Final)"
    echo "   - Version: Windows 10"
    echo "   - Edition: Windows 10 22H2"
    echo "   - Language: English"
    echo "   - Architecture: x64"
    echo ""
    echo "3. Click download - gives you official Microsoft link"
    echo ""
fi

echo ""
echo "=== Alternative: Download with aria2c (faster) ==="
echo ""
echo "Install aria2c (download accelerator):"
echo "  sudo apt install aria2 -y"
echo ""
echo "Then download from official mirror (if link works):"
echo "  aria2c -x 16 -s 16 'DOWNLOAD_URL_HERE'"
echo ""
echo "The -x 16 -s 16 uses 16 connections for faster download"
echo ""

echo "When download completes:"
echo "  1. Verify hash: sha256sum ~/Downloads/torrents/*.iso"
echo "  2. Copy to desktop: scp ~/Downloads/torrents/*.iso monk:/mnt/data/VirtualMachines/"
echo "  3. Run setup: ./setup-tableau-TODAY.sh"
echo ""
