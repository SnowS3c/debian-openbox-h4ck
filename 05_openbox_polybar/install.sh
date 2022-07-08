#!/bin/bash
# ACTION: Install Polybar and essential tools and configs
# INFO: Polybar is a lightweight window manager, but needs some additional tools and configs for make it usable
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update
sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev git build-essential libuv1-dev


cd /tmp/
git clone --recursive https://github.com/polybar/polybar
cd polybar/
mkdir build
cd build/
cmake ..
make -j$(nproc)
sudo make install

#polywins
sudo apt-get install wmctrl


# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /etc/skel /home/*/ ; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes

    [ ! -d "$d/.config" ] && mkdir -v "$d/.config" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/.config/"
    [ ! -d "$d/.config/polybar" ] && mkdir -v "$d/.config/polybar" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d/.config/polybar/"


    [ ! -d "$d/.config/bin" ] && mkdir -v "$d/.config/bin" && chown -R $(stat "$d" -c %u:%g) "$d/.config/bin/"
    cp -v "${base_dir}/ethernet_status.sh" "$d/.config/bin/" && chmod +x "$d/.config/bin/ethernet_status.sh"
    cp -v "${base_dir}/hackthebox_status.sh" "$d/.config/bin/" && chmod +x "$d/.config/bin/hackthebox_status.sh"
    cp -v "${base_dir}/target_status.sh" "$d/.config/bin/" && chmod +x "$d/.config/bin/target_status.sh"
	sed -i "s/username/$(basename $d)/" "$d/.config/bin/target_status.sh"
	cp -v "${base_dir}/target.txt" "$d/.config/bin/" && chown -R $(stat "$d" -c %u:%g) "$d/.config/bin/target.txt"
    cp -v "${base_dir}/copy_target.sh" "$d/.config/bin/" && chown -R $(stat "$d" -c %u:%g) "$d/.config/bin/copy_target.sh" && chmod +x "$d/.config/bin/copy_target.sh"
	sed -i "s/username/$(basename $d)/" "$d/.config/bin/copy_target.sh"


	cp -vr "${base_dir}/polybar/" "$d/.config/" && chown -R $(stat "$d" -c %u:%g) "$d/.config/polybar"
    chmod +x "$d/.config/polybar/material/scripts/updates.sh" "$d/.config/polybar/material/launch.sh" "$d/.config/polybar/material/scripts/polywins.sh"

    echo '~/.config/polybar/material/./launch.sh' >> "$d/.config/openbox/autostart"

done

[ ! -d "/usr/share/fonts" ] && mkdir -vp "/usr/share/fonts" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "/usr/share/fonts/"
cp -vr "${base_dir}"/fonts/* "/usr/share/fonts/" 


fc-cache -v

