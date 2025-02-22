# Openbox script collection and pentesting tools for Debian 11

Thanks to [**`leomarcov`**](https://github.com/leomarcov/) for making the project [**`debian-openbox`**](https://github.com/leomarcov/debian-openbox).
This project is based on that one but adding polybar, pentesting tools and some changes in the configuration of vim, tmux and terminator.

<img align="left"  src="https://user-images.githubusercontent.com/32820131/79635263-47d9d580-8170-11ea-87b1-943144be83d7.png" width="90"> Openbox is a beautiful and lightweight window manager, but tediuos to install and config a full usable environment. This script collection automatize **Openbox** installation and essentials tools and apply configurations, styles and themes. You can install all scripts from bare Debian netinstall to config full environment or **exec only some scripts** you are interested. Each folder has a particular action script for install pacakges, add scripts, apply configs or install some themes or styles.

The main script `install` can exec all scripts or only a select list:
  * `install`: exec all scripts interactively.
  * `install -l`: list all scripts.
  * `install -d`: install all scripts with default option Y.
  * `install -a 5,8-12`: exec selected scripts.
  * `install -a grub`: exec all actions with `grub` in description.

&nbsp; 
## Main features
  * Install Openbox and dependences.
  * Install and config essential Openbox tools: Tint2, Rofi, Terminator, Thunar, volume control, gsimplecal, etc.
  * Config a basic themes and styles for Openbox, Gtk, fonts, icon pack, wallpapers, exit menu.
  * Install some user tools: Chrome browser, SublimeText, Atom, VirtualBox and Extensión Pack, sudo,nomacs image viewer, WPS Office and others.
  * Config prompt,  path, aliases and home directories permissions.
  * Config Grub for skip menu or protect by password and show messages during boot.
  * Install [**`vim`**](https://github.com/snows3c/debian-openbox-h4ck/tree/master/install_vim) and some plugins and themes.
  * Install [**`Numix-Paper icon theme`**](https://github.com/snows3c/debian-openbox-h4ck/tree/master/10_openbox_numix-paper-icons), a theme based on Numix and Paper icon packs.
  * Install [**`autosnap Windows for Openbox`**](https://github.com/snows3c/debian-openbox-h4ck/tree/master/10_openbox_autosnap), a script for autosnap active windows (half-maximice). 
  * Install [**`loginfetch`**](https://github.com/snows3c/debian-openbox-h4ck/blob/master/script_loginfetch/README.md), a tty login based on ufetch style and config tty lock screen with physlock.
  * Install [**`update-notification script`**](https://github.com/snows3c/debian-openbox-h4ck/tree/master/10_openbox_update-notification) for check and manage repositories updates.
  * Install [**`brightness control script`**](https://github.com/snows3c/debian-openbox-h4ck/tree/master/script_brightness-control) for increase/decrease birghtness screen.
  * Install [**`exit menu`**](https://github.com/snows3c/debian-openbox-h4ck/tree/master/10_openbox_exit-menu) based on rofi to show power and exit options.
  * Install [**`pentesting tools`**](https://github.com/SnowS3c/debian-openbox-h4ck/tree/master/install_pentesting_tools): evil-winrm, nmap, whatweb, hydra, cadaver, masscan, wfuzz, gobuster, metasploit, searchsploit, johnTheRipper, wireshark and more.


<img align="center" width="410" src=https://user-images.githubusercontent.com/73076414/178058844-8c4c50dd-6d9c-46f0-bafc-2078f8c2361f.png> <img align="center" width="410" src=https://user-images.githubusercontent.com/73076414/178059069-5bd156ac-99cc-4d82-bbb1-246053f74746.png> 

<img align="center" width="410" src="https://user-images.githubusercontent.com/73076414/178059287-3f8d793f-58d4-4197-9a71-fae9095f7ccb.png"> <img align="center" width="410" src="https://user-images.githubusercontent.com/32820131/81058996-de77f780-8ecf-11ea-9ec0-aa089c637c8a.png">


&nbsp; 
## Install
  * Install Debian 10/11 using netinstall image. Its recommended don't install `Debian desktop environment`, install only `standard system utilities`.
<img align="center" width="700" src="https://user-images.githubusercontent.com/32820131/101158317-d467d400-362b-11eb-8759-9d3beb40a20c.png">
  
  * Connect to Internet. If you need to connect to WIFI network in CLI you can do:
  ```
  ip a                                            # To get your wlan interface name, mine is wlp5s0
  iwlist wlp5s0 scan | egrep "Address|ESSID"      # To get available wifi networks
  wpa_supplicant -B -i wlp5s0 -c <(wpa_passphrase YOUR-SSID YOUR-PASS)  # To authenticate in your wifi network
  dhclient -v wlp5s0                              # To get DHCP IP
  ```
  * Install git: `apt install git`
  * Clone or download this project: `git clone https://github.com/snows3c/debian-openbox-h4ck`
  * Exec `install` script and select scripts you want to install.
  
```
$ ./install -h
Exec a set of scripts
Usage: install [-l] [-a <actions>] [-y] [-d] [-h]
   -l		Only list actions 
   -a <actions>	Filter selected actions by number range or text pattern (comma separated)
   -y		Auto-answer yes to all actions
   -d		Auto-answer default to all actions
   -h		Show this help


# Exec all actions interactively:
$ ./install

# Exec all actions and answer yes to all (no ask):
$ ./install -y

# Exec all actions and answer default to all (no ask and only exec actions with default Y):
$ ./install -d

# Exec only actions 5,7,10,11,12,13,14 and 15:
$ ./install -a 5,7,10-15

# Exec only actions with grub text in description:
$ ./install -a grub

# List all actions:
$ ./install -l
 NUM    TYPE    DESCRIPTION
=======================================================================================================================
 [1]   CONFIG   Add Debian repositories contrib and non-free (Y)
 [2]   INSTALL  Install some basic packages (Y)
 [3]   OPENBOX  Install Openbox WM and essential tools and configs (Y)
 [4]   OPENBOX  Install Polybar and essential tools and configs (Y)
 [5]   OPENBOX  Install theme Arc GTK and set as default (Y)
 [6]   OPENBOX  Install script autosnap for half-maximize windows with mouse middle click in titlebar (Y)
 [7]   OPENBOX  Install script obexit with exit-power menu based on rofi (Y)
 [8]   OPENBOX  Install some popular fonts (Y)
 [9]   OPENBOX  Install icon theme Mkos-Big-Sur (Y)
 [10]  OPENBOX  Install nomacs image viewer (Y)
 [11]  OPENBOX  Install clear xfce4-notify theme (Y)
 [12]  OPENBOX  Install icon theme Numix-Paper and set as default icons (Y)
 [13]  OPENBOX  Install rofi launcher and config as default launcher (Y)
 [14]  OPENBOX  Install Terminator terminal and configs (Y)
 [15]  OPENBOX  Install Thunar filemanager and some configs (show toolbar and double-click for active items) (Y)
 [16]  OPENBOX  Install tint2 taskbar and config some taskbar/menu themes (N)
 [17]  OPENBOX  Install script update-notification for check periodically APT updates (Y)
 [18]  OPENBOX  Install pnmixer and pavucontrol volume control (Y)
 [19]  OPENBOX  Install script to rotate everyday Linux solarized wallpapers pack by Andreas Linz (N)
 [20]  OPENBOX  Install nitrogen tool, copy wallpapers pack and set default wallpaper to all users (Y)
 [21]  CONFIG   Config some useful aliases (for ls, grep and ip commands) (Y)
 [22]  CONFIG   Config modified .profile file with new path (sbin for all users) and color definitions (Y)
 [23]  CONFIG   Config new bash prompt (Y)
 [24]  CONFIG   Config system for show text messages during boot time (Y)
 [25]  CONFIG   Disable some unnecessary services (Y)
 [26]  CONFIG   Config GRUB with password protection for prevent users edit entries (N)
 [27]  CONFIG   Config GRUB for skip menu (timeout=0) (N)
 [28]  CONFIG   Config users home directories permissions to 750 (for current and future users) (Y)
 [29]  CONFIG   Enable CTRL+ALT+BACKSPACE shortcut for kill X server (Y)
 [30]  CONFIG   Install sudo and add user 1000 to sudo group (Y)
 [31]  INSTALL  Install Atom text editor (N)
 [32]  INSTALL  Install CUPS printer system and add user 1000 to lpadmin group (N)
 [33]  INSTALL  Install Firefox, add to repositories and set has default browser (Y)
 [34]  INSTALL  Install Google Chrome, add to repositories (Y)
 [35]  INSTALL  Install pentesting tools (Y)
 [36]  INSTALL  Install Sublime Text, add repositories and set as default editor (Y)
 [37]  INSTALL  Install tmux and add some configs (Y)
 [38]  INSTALL  Install vim editor, and apply some configs and plugins (Y)
 [39]  INSTALL  Install VirtualBox 6.1 and Extension Pack and add to repositories  (N)
 [40]  INSTALL  Install Visual Studio Code and add repositories (N)
 [41]  INSTALL  Install WPS Office Suite (N)
 [42]  SCRIPT   Install script poweroff_last for auto-poweroff if no users logged in 20 minutes (N)
 [43]  SCRIPT   Install script to control screen brightness (Y)
 [44]  SCRIPT   Config Linux login in text mode (tty) using ufetch style and install a tty locker (physlock) (Y)
```
  
&nbsp; 
## Customize
The script can be easily customized. Each `install.sh` script placed in a subdirectory are automatillacy recognized by `install`.
  * For **remove action** simply delete the action directory.
  * For **add action** simply add new folder and place inside `install.sh` script and dependences. `install.sh` script must have this header:
  ```
  #!/bin/bash
  # ACTION: Description of the action
  # INFO: Optional additional info
  # DEFAULT: y
  
  scripts commands to do action
  
  ```

&nbsp;  
## Lincense
[GPLv3](LICENSE)

## Contact
My name is Antonio Sánchez. I'm UNIX/LINUX system administrator in Spain.

You can email me for suggestions, contributions, debian-openbox-h4ck script help or share your feelings: aslopez110@gmail.com
