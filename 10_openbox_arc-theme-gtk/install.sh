#!/bin/bash
# ACTION: Install theme Arc GTK and set as default
# INFO: Arc GTK theme is a clear and cool GTK theme
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
gtk_default="Arc-Dark"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update  
apt-get install -y arc-theme
apt-get install -y gtk3-nocsd		# Force show titlebar in GTK3 new windows

# Change accent color blue (#5294e2) for grey:
find /usr/share/themes/Arc -type f -exec sed -i 's/#5294e2/#b3bcc6/g' {} \;   

# New theme.
# git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in  /etc/skel/ /home/*/ ; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes
	

	# New themes package Arc-Clone
	[ ! -d "$d/.themes" ] && mkdir "$d/.themes"
	git clone https://github.com/addy-dclxvi/openbox-theme-collections "$d"/.themes

	f="$d/.gtkrc-2.0"
	[ ! -f "$f" ] && cp -v "$base_dir/gtkrc-2.0" "$d/.gtkrc-2.0" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$f"
	sed -i 's/^gtk-theme-name *= *.*/gtk-theme-name="'"$gtk_default"'"/' "$f"		

	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/gtk-3.0/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	
	f="$d/settings.ini"
	[ ! -f "$f" ] && cp -v "$base_dir/settings.ini" "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$f"	
	sed -i 's/^gtk-theme-name *= *.*/gtk-theme-name='"$gtk_default"'/' "$f"


done
