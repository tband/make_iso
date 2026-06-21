# make_iso.sh - Easy ISO Customization Tool

make_iso.sh adds preseed data and adds/updates packages to an existing Linux Mint ISO image to speed up the installation.
The preseeded ISO image can be flashed to an USB stick or served from a iPXE server for centralized installation.
## 🎯 What Does This Tool Do?

Imagine you have a Linux installation CD (ISO file). This tool helps you:
- **Automate the installation** so you don't have to answer questions
- **Add or update software** automatically
- **Create a custom version** that installs exactly what you want
- **Make it foolproof** for anyone to use

## Installation Steps

You need a Linux computer with internet. Open a terminal.
```bash
git clone https://github.com/tband/make_iso
cd make_iso
# Download Linux Mint (this takes a while, ~2-3 GB)
wget https://ftp.nluug.nl/os/Linux/distr/linuxmint/iso/stable/22.3/linuxmint-22.3-cinnamon-64bit.iso
# Download the verification file
wget https://ftp.nluug.nl/os/Linux/distr/linuxmint/iso/stable/22.3/sha256sum.txt
# IMPORTANT: Verify the download is correct
shasum -c sha256sum.txt
# You should see: linuxmint-22.3-cinnamon-64bit.iso: OK
```
## Create Your Custom ISO
```bash
./make_iso.sh -i linuxmint-22.3-cinnamon-64bit.iso --update --signal --winboat
# Wait a few minutes..
# When done, you'll see something like:
# linuxmint-22.3-cinnamon-64bit-2026-01-20.iso has been created
```
## Use Your Custom ISO
### Burn to USB drive
```bash
# Find your USB drive (BE CAREFUL - wrong choice erases data!)
lsblk
# Look for something like sdb, sdc (NOT sda which is your main drive)

# Write the ISO to USB (REPLACE /dev/sdX with your USB device)
sudo dd if=linuxmint-22.3-cinnamon-64bit-2026-01-20.iso of=/dev/sdX bs=4M status=progress
```
#### PXE boot
Install and configure a IPXE server using https://github.com/tband/linux-employ
   ```bash
   sudo ./install.sh --iso linuxmint-22.3-cinnamon-64bit-2026-01-20.iso
   ```
## Update
To update the packages in the ISO run make_iso.sh --update.
```bash
cd make_iso
git pull # update the make_iso.sh script
# Use the old iso as input, no need to re-add signal or winboat, just update
./make_iso.sh -i linuxmint-22.3-cinnamon-64bit-2026-01-20.iso --update
# linuxmint-22.3-cinnamon-64bit-2026-02-03.iso has been created
```

## 📖 Understanding the Options

### Basic Options

| Option | What It Does | When to Use |
|--------|--------------|-------------|
| `-i file.iso` | Input file (required) | Always needed |
| `-o file.iso` | Output file name | If you want a specific name |
| `--update` | Updates all software in the ISO | When the ISO is old |
| `--help` | Shows all options | When you're confused |

### Advanced Options

| Option | What It Does | For Who |
|--------|--------------|----------|
| `--chroot` | Opens a command prompt inside the ISO | Advanced users who want to manually add/remove things |
| `--signal` | Installs Signal messaging app | If you want Signal pre-installed |
| `--winboat` | Installs WinBoat for Windows apps | If you need to run Windows programs |

## 🛠️ What Happens Behind the Scenes?

Don't worry about these details, but here's what the script does:

1. **Checks for tools** - Automatically installs xorriso, squashfs-tools, bsdtar if missing
2. **Extracts** the original ISO (like opening a zip file)
3. **Updates** software if you asked for it (like running Windows Update)
4. **Installs** extra programs if requested (like adding apps to your phone)
5. **Adds** automated installation settings (so you don't click "Next" 50 times)
6. **Rebuilds** everything into a new ISO (like zipping it back up)
7. **Creates** a checksum file (like a fingerprint to verify it's correct)

## 🤔 Common Questions

### "How long does it take?"
- Downloading Linux Mint: 10-30 minutes (depending on internet)
- Creating custom ISO: 5-15 minutes
- Total: 15-45 minutes

### "How big will the file be?"
- Original Linux Mint: ~2.8 GB
- Custom ISO: ~3.5-4 GB (bigger because of updates and extra software)

### "Can I use this on Ubuntu or other Linux?"
- Yes! It works with most Debian-based Linux distributions
- The script was designed for Linux Mint but works with Ubuntu, Debian, etc.

### "What if I get an error?"

**Common errors and fixes:**

1. **"Permission denied"**
   - Fix: Make script executable: `chmod +x make_iso.sh`

2. **"ISO already exists"**
   - Fix: Delete old output file or use different output name with `-o`

3. **"Not enough space"**
   - Fix: Free up at least 10 GB on your hard drive

4. **"sudo password required"**
   - The script may ask for sudo password to install tools or mount filesystems
   - This is normal and safe

## 💡 Tips for Success

1. **Use a fast USB drive** (USB 3.0 or better) for better performance
2. **Verify downloads** - always run `shasum -c` to avoid corrupted files
3. **Backup important data** before writing to USB (it erases everything!)
4. **Test in a virtual machine** first if you're unsure
5. **Keep the original ISO** so you can create different versions

## 📚 What Each Option Really Means

### `--update`
This runs `apt-get update && apt-get dist-upgrade` inside the ISO, so:
- Security patches are included
- Bug fixes are applied
- Software is current

### `--signal` and `--winboat`
These install extra software:
- **Signal**: Encrypted messaging app (like WhatsApp but more private)
- **WinBoat**: Lets you run some Windows programs on Linux

### `--chroot`
This is like "going inside" the ISO to make changes:
- You get a command prompt
- You can install/uninstall programs
- You can edit configuration files
- Type `exit` when done

## 🎓 Real-World Examples

### Example 1: Basic Automated Install
```bash
./make_iso.sh -i linuxmint.iso -o my_mint.iso
```
Result: ISO that installs Linux Mint without asking questions

### Example 2: Updated with Signal
```bash
./make_iso.sh -i linuxmint.iso --update --signal
```
Result: Latest software + Signal messaging app

### Example 3: Everything Included
```bash
./make_iso.sh -i linuxmint.iso -o repair_cafe.iso --update --signal --winboat
```
Result: Complete system with updates, Signal, and Windows app support

## ⚠️ Important Warnings

1. **USB drives are erased completely** - no undo!
2. **Large downloads** - make sure you have 5+ GB free
3. **Time commitment** - first time takes 30-60 minutes
4. **Verify everything** - always check checksums
5. **Test before deploying** - try on one computer first

## 🆘 Need More Help?

- Check the original GitHub: https://github.com/tband/make_iso
- Read the script comments: open `make_iso.sh` in a text editor
- Join Linux communities for support

## ✅ Success Checklist

- [ ] Linux computer with internet connection
- [ ] Downloaded Linux Mint ISO
- [ ] Verified ISO with shasum
- [ ] Have 10+ GB free space
- [ ] Understand what USB drive you'll use
- [ ] Ready to wait 20-60 minutes

**You're ready to create your custom Linux ISO!** 🎉
