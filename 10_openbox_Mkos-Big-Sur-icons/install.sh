#!/bin/bash
# ACTION: Install icon theme Mkos-Big-Sur
# INFO: Mkos-Big-Sur theme
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
icon_default="Mkos-Big-Sur"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }


echo -e "\e[1mInstalling Mkos-Big-Sur icon pack...\e[0m"
[ -d "/usr/share/icons/" ] && mkdir -p "/usr/share/icons"
tar -xzvf "${base_dir}/Mkos-Big-Sur.tar.gz" -C /usr/share/icons

