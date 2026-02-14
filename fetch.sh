#!/bin/bash

# Strip Arch suffix: 6.18.9-arch1-2 → 6.18.9
kernel=$(uname -r | cut -d '-' -f 1)

files=(
  btusb.c
  btintel.h
  btrtl.h
  btbcm.h
  btmtk.h
)

for f in "${files[@]}"; do
  curl -L -o "$f" -w "URL: %{url_effective}\n" \
    "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/$f?h=v$kernel"
done
