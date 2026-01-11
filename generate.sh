#!/usr/bin/env bash

set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Please run this script inside the git repo!"
    exit 1
fi

if [ "$(pwd -P)" = "/" ]; then
    echo "To protect your computer, this script cannot be run inside your root directory"
    exit 1
fi

if [ ! -d ".git" ]; then
    echo "Please run this script inside the main directory of the git repo!"
    exit 1
fi

echo "Warning: This script will remove some files inside the current directory. Dir: $(pwd -P)"
read -rp "Continue? [yes/NO] " ans
[[ "$ans" == "yes" ]] || exit 1

wget http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/13.5-RELEASE/base.txz
aunpack base.txz
rm -rf base/bin/
rm -rf base/var/
rm -rf base/sbin/
rm -rf base/boot/
rm -rf base/rescue/
rm -rf base/usr/bin/
rm -rf base/usr/sbin/
rm -rf base/usr/tests/
rm -rf base/usr/share/
rm -rf base/usr/lib/clang/

rm -rf dev
rm -rf etc
rm -rf lib
rm -rf libexec
rm -rf media
rm -rf mnt
rm -rf net
rm -rf proc
rm -rf root
rm -rf tmp
rm -rf usr
rm -rf .cshrc
rm -rf .profile
rm -rf COPYRIGHT
rm -rf sys

chmod 777 base/proc
chmod 777 base/dev
rm -rf base/dev
rm -rf base/proc

mv base/{.,}* .
rm -rf base base.txz