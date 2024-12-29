#!/bin/bash
# Yep, this script is inspired by winesapOS. Check it out! 
# https://github.com/winesapOS/winesapOS

# Load default environment variables.
../env/gsos_default.sh

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Please use sudo." 1>&2
   exit 1
fi

if [[ "${GUESTSNEEZEOS_DE}" == "plasma" ]]; then
   echo "Installing the KDE Plasma desktop environment..."
   echo "plasma-meta" >> "src/packages.x86_64"
   echo "plasma-nm" >> "src/packages.x86_64"
   # The KDE Plasma theme is by @LukeShortCloud, go follow him!
   cd ../ # Move to parent directory
   wget https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-rel/os/x86_64/steamdeck-kde-presets-0.16-1-any.pkg.tar.zst
   zstd -d steamdeck-kde-presets-0.16-1-any.pkg.tar.zst
   mv steamdeck-kde-presets-0.16-1-any.pkg.tar/ GuestSneezeOS/
   cd GuestSneezeOS/
   cd steamdeck-kde-presets-0.16-1-any.pkg.tar/
   mv etc/ ../airootfs/
   mv usr/ ../airootfs/
   cd ../
   rm -rf steamdeck-kde-presets-0.16-1-any.pkg.tar/
   
elif [[ "${GUESTSNEEZEOS_DE}" == "hyprland" ]]; then
   echo "Hyprland is coming soon!"
fi


# Finally, build
rm -rf out/ work/
src/archiso/archiso/mkarchiso -v -w work/ -o out/ src/ 