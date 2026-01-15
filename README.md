# make_iso Project Overview

make_iso.sh adds preseed data and adds/updates packages to an existing Linux Mint ISO image to speed up the installation.
The preseeded ISO image can be flashed to an USB stick or served from a iPXE server for centralized installation.

### Key Features
```
- Fully automated install
- Unattended software updates
- Install the non-free mint-meta-codecs
- A manual is placed on the user's desktop
- Install cheese to test webcam support
- Optional: Install signal-desktop
- Optional: Install winboat
```
## Installation Steps

- To get started, run the following commands to create an installation image in iso format (internet access required):
```bash
git clone https://github.com/tband/make_iso
cd make_iso
wget https://ftp.nluug.nl/os/Linux/distr/linuxmint/iso/stable/22.3/linuxmint-22.3-cinnamon-64bit.iso
wget https://ftp.nluug.nl/os/Linux/distr/linuxmint/iso/stable/22.3/sha256sum.txt
shasum -c sha256sum.txt
  #  linuxmint-22.3-cinnamon-64bit.iso: OK
./make_iso.sh -i linuxmint-22.3-cinnamon-64bit.iso --update --signal --winboat
  # linuxmint-22.3-cinnamon-64bit-2026-01-15.iso has been created
  # -rw-r--r-- 1 thba thba 3925868544 15 jan 18:33 linuxmint-22.3-cinnamon-64bit-2026-01-15.iso
  # -rw-r--r-- 1 thba thba        111 15 jan 18:33 linuxmint-22.3-cinnamon-64bit-2026-01-15.sha256sum

  # To make a bootable pendrive, insert it now
  # list block devices and umount if auto mounted
  # lsblk # (find <X>)
  # sudo umount /dev/sd<X> or /dev/sd1<X>
  # sudo dd if=linuxmint-22.3-cinnamon-64bit-2026-01-15.iso of=/dev/sd<X> oflag=direct bs=4M status=progress
  # linuxmint-22.3-cinnamon-64bit_preseeded.iso has been created
   ```
   - Optional: Install and configure a IPXE server using https://github.com/tband/linux-employ
   ```bash
   sudo ./install.sh --iso linuxmint-22.3-cinnamon-64bit_preseeded.iso
   ```

### commandline help
```
$ ./make_iso.sh -h

make_iso.sh
  -i           <file> input.iso
  -o           <file> output.iso
  --update,-u  Update the packages.
  --chroot,-c  This option gives a root shell in the ISO to make modifications. Things you can
               do is adding, removing packages with apt-get.
  --winboat,-w Install winboat to run Window applications
  --version,-v Show version
  --help,-h    This help

Create a new ISO with preseed embedded
Examples:
  ./make_iso.sh -i linuxmint.iso -o linuxmint_preseeded.iso
  ./make_iso.sh -i linuxmint.iso -o linuxmint_updated.iso --update
```

## Update
To update the packages in the ISO run make_iso.sh --update
You can use a previously generated ISO as input to only update the packages or start from the original Mint installation ISO.
