import socket
import os
# Note: Do NOT use from imports for global variables
# BAD: from decman import packages/modules/etc
import decman
import decman.config
# This is fine since the thing being imported is a class and not a global variable.
from decman import UserPackage, File, Directory, UserRaisedError

# my normal packages
decman.packages += [
    "cachyos-snapper-support",
    "grub-btrfs-support",
    # config ui for snapshots
    "btrfs-assistant",
    # "grub-customizer",
    "vivaldi",
    "git",
    "python",
    "kitty",
    "neovim",
        "xclip",
    "nodejs",
    "stow",
    "fzf",
        "bat",
        "the_silver_searcher",
        "ripgrep",
    "tmux",
    "xclip",
    "pixi",
    "yazi",
        "poppler",
        "ffmpegthumbnailer",
        "imagemagick",
    "discord",
    # for tresorit
    "fuse3",
    "signal-desktop",
    "sway",
        "wofi",
        # still needed for sway-screenshot
        "grim",
        "swaybg",
    "r",
        "gcc-fortran"

]

decman.aur_packages += [
    "decman",
    "sway-screenshot",
    "ferdium-bin",
    "etcher-bin",
    # fails - cursed to use the downloaded installer forever I think.
    # "tresorit"
    # first run:
    # curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | gpg --import -
    "spotify"

]

if socket.gethostname() != "tyrell-work":
    # personal system stuff
    decman.packages += [
        "vlc",
        "obs-studio",
        "gimp",
    ]
    decman.aur_packages += [
        "surfshark-client",
        "viber",
    ]
else:
    # work system stuff
    decman.packages += [
        "openconnect",
        "cifs-utils"
    ]

# mostly untouched cachy system derived from running decman and seeing what it said would be erased
base_cachy_packages = [
    "accountsservice", "adobe-source-han-sans-cn-fonts", "adobe-source-han-sans-jp-fonts",
    "adobe-source-han-sans-kr-fonts", "adwaita-icon-theme", "alacritty", "alsa-firmware",
    "alsa-plugins", "alsa-utils", "awesome-terminal-fonts", "baobab", "base", "base-devel",
    "bash-completion", "bind", "bluez", "bluez-hid2hci", "bluez-libs", "bluez-utils", "btop",
    "btrfs-assistant", "btrfs-progs",
    "cachyos-hooks", "cachyos-kernel-manager", "cachyos-keyring",
    "cachyos-mirrorlist", "cachyos-packageinstaller", "cachyos-plymouth-theme", "cachyos-rate-mirrors",
    "cachyos-settings", "cachyos-v3-mirrorlist", "cachyos-v4-mirrorlist", "cachyos-wallpapers",
    "cachyos-zsh-config", "chwd", "cpupower", "cryptsetup", "decibels", "device-mapper", "dhclient",
    "diffutils", "dmidecode", "dmraid", "dnsmasq", "dosfstools", "duf", "e2fsprogs", "efibootmgr",
    "efitools", "eog", "epiphany", "ethtool", "evince", "exfatprogs", "f2fs-tools", "ffmpegthumbnailer",
    "file-roller", "fsarchiver", "gdm", "gedit", "glances",
    "gnome-backgrounds", "gnome-calculator",
    "gnome-calendar", "gnome-characters", "gnome-clocks", "gnome-color-manager", "gnome-connections",
    "gnome-console", "gnome-contacts", "gnome-control-center", "gnome-disk-utility", "gnome-font-viewer",
    "gnome-keyring", "gnome-logs", "gnome-maps", "gnome-menus", "gnome-music", "gnome-nettool",
    "gnome-power-manager", "gnome-remote-desktop", "gnome-screenshot", "gnome-session",
    "gnome-settings-daemon", "gnome-shell", "gnome-shell-extensions", "gnome-software",
    "gnome-system-monitor", "gnome-terminal", "gnome-text-editor", "gnome-themes-extra", "gnome-tour",
    "gnome-tweaks", "gnome-usage", "gnome-user-docs", "gnome-user-share", "gnome-weather",

    "grilo-plugins", "grub", "grub-hook", "gst-libav", "gst-plugin-pipewire", "gst-plugins-bad",
    "gst-plugins-ugly", "gvfs", "gvfs-afc", "gvfs-dnssd", "gvfs-goa", "gvfs-google", "gvfs-gphoto2",
    "grilo-plugins", "grub", "grub-hook", "gst-libav", "gst-plugin-pipewire", "gst-plugins-bad",
    "gst-plugins-ugly", "gvfs", "gvfs-afc", "gvfs-dnssd", "gvfs-goa", "gvfs-google", "gvfs-gphoto2",
    "gvfs-mtp", "gvfs-nfs", "gvfs-onedrive", "gvfs-smb", "gvfs-wsdd", "haveged", "hdparm", "hwdetect",
    "hwinfo", "inetutils", "intel-media-driver", "intel-ucode", "iptables-nft", "iwd", "jfsutils",
    "less", "lib32-libva-intel-driver", "lib32-mesa",
    # removing these two fixed the install/remove dependency thing I was having
    # "lib32-opencl-rusticl-mesa", "opencl-rusticl-mesa",
    "lib32-vulkan-intel",
    "libdvdcss", "libgsf", "libnma", "libopenraw", "libva-intel-driver", "libwnck3", "linux-cachyos",
    "linux-cachyos-headers", "linux-firmware", "logrotate", "loupe", "lsb-release", "lsscsi", "lvm2",
    "malcontent", "man-db", "man-pages", "mdadm", "meld", "mesa-utils",
    "mkinitcpio",
    "modemmanager", "mtools",
    # "nano", "nano-syntax-highlighting",
    "nautilus", "neovim", "netctl",
    "networkmanager-openvpn", "nfs-utils", "nilfs-utils", "noto-color-emoji-fontconfig", "noto-fonts",
    "noto-fonts-cjk", "noto-fonts-emoji", "nss-mdns", "ntp", "octopi",
    "opendesktop-fonts", "openssh", "orca", "os-prober", "pacman-contrib", "paru", "pavucontrol",
    "perl", "pipewire-alsa", "pipewire-pulse", "plocate", "plymouth", "poppler-glib", "power-profiles-daemon",
    "pv", "python-defusedxml", "python-packaging", "qt6-wayland", "rebuild-detector", "reflector",
    "ripgrep", "rsync", "rtkit", "rygel", "s-nail", "sg3_utils", "simple-scan", "smartmontools", "snapper",
    "snapshot", "sof-firmware", "stow", "sudo", "sushi", "sysfsutils", "tecla", "texinfo", "totem",
    "ttf-bitstream-vera", "ttf-dejavu", "ttf-liberation", "ttf-meslo-nerd", "ttf-opensans", "ufw", "unrar",
    "unzip", "upower", "usb_modeswitch", "usbutils", "vi", "vim", "vivaldi", "vulkan-intel", "wget",
    "which", "wireless-regdb", "wireplumber", "wpa_supplicant", "xdg-desktop-portal-gnome", "xdg-user-dirs",
    "xdg-user-dirs-gtk", "xf86-input-libinput", "xfsprogs", "xl2tpd", "xorg-server", "xorg-xdpyinfo",
    "xorg-xinit", "xorg-xinput", "xorg-xkill", "xorg-xrandr", "yelp",
    # added these manually after it asked to delete them:
    "libndp", "libnewt", "libteam", "networkmanager", "network-manager-applet"
]

decman.packages += base_cachy_packages

# Ignored packages can be normal packages or aur packages.
decman.ignored_packages += [
    # per the docs
    "decman-git"
]

decman.config.debug_output = False
decman.config.suppress_command_output = True
decman.config.quiet_output = False
# If you don't want to print lines that contain keywords, set this to False
decman.config.print_pacman_output_highlights = True
# The user which builds aur and user packages.
decman.config.makepkg_user = "thadryan" # This was set in a previous example. Let's not override it.
# The build directory decman uses for creating a chroot etc.
decman.config.build_dir = "/tmp/decman/build"
# Built packages are stored here.
decman.config.pkg_cache_dir = "/var/cache/decman"
# Timeout in seconds for fetching aur package details.
decman.config.aur_rpc_timeout = 30
# Enable installing and upgrading foreign packages.
decman.config.enable_fpm = True
# Number of package files per package kept in the cache
# All built AUR packages and user packages are stored in cache.
decman.config.number_of_packages_stored_in_cache = 2
# Decman captures pacman command output, and any line (and adjacent lines) that contains any of
# the following keywords (case-insensetive) will be printed after the pacman command finishes.
# REMEMBER: You should still generally pay attention to pacman output
# since these keywords may not catch all cases.
decman.config.pacman_output_keywords = [
    "pacsave",
    "pacnew",
    # Additional keywords can be:
    # "warning",
    # "error",
    # "note",
    # They might cause too many highlights however.
]
# You then must set the user that builds the packages to the owner of the GPG home.
decman.config.makepkg_user = "thadryan"
