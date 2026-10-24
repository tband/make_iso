#!/usr/bin/env bash

# NOTE: Script will be run during creation of ISO inside a chroot (make_iso.sh --update)

PATH=$PATH:/usr/sbin
#ufw --force enable 2> /dev/null
#ufw default deny incoming
apt-get update
apt-get --yes install wdutch cheese mint-meta-codecs
apt-get --yes dist-upgrade
apt-get autoremove --purge -y
rm -rf var/lib/apt/lists/*
apt-get clean
