<h1 align=center> nkiss </h1>


nkiss is mostly a minimal grab bag of preinstalled packages meant as a kickstarter for a fresh vanilla arch system (in niri), specifically right after an archinstall.

It leaves you with a system that's not supposed to be "complete" or "productive", that system will need tinkering to suit your needs, but it should take fewer steps to get there.

Hardware setup is documented here [DRIVERS.md](docs/DRIVERS.md)

Archinstall options 
=========

nkiss relies on a specific archinstall configuration so it's not recommended to run nkiss with a different one

<pre>
Disk configuration/
├─ Partitioning/
│  ├─ Default partition layout
│  ├─ btrfs
│  ├─ Use subvolumes
│  ├─ Use compression
├─ Disk encryption/
│  ├─ Encryption type (LUKS)
│  ├─ Encryption password (     )
│  ├─ Partitions (     )
│  ├─ Btrfs snapshots (Snapper)
Bootloader/
├─ limine
Authentication/
├─ User account
├─ Add a user (with sudo)
Applications/
├─ Audio
├─ Pipewire
Network configuration/
├─ Copy ISO network config
Additional Packages/
├─ git
├─ curl
</pre>
Reboot once the installation is complete

 Additionally it's not recommended to run nkiss if:

-	The system has BIOS instead of UEFI
-	Is non-vanilla arch, like CachyOS or Garuda
-	Running as root
-	Gnome or KDE Plasma is installed

then git clone this

```shell
git clone https//somelink
```

# The system post-install

## General/unsorted

Note that nkiss disables mkinitcpio hooks during the installation process, and re-enables them once complete. This is for the purpose of a faster installation. 

mkinitcpio hooks are setup in `/etc/mkinitcpio.conf.d/nkiss_hooks.conf`
`HOOKS=(base udev plymouth keyboard autodetect microcode modconf kms keymap consolefont block encrypt filesystems fsck btrfs-overlayfs)`

Most are standard and explained [in this arch wiki article](https://wiki.archlinux.org/title/Mkinitcpio#Hook_list) except for `plymouth` and `btrfs-overlays` ????



## Pacman
nkiss edits `pacman.conf` slightly with these lines uncommented:

```
ParallelDownloads = 5
Color
```

so you download packages faster and get colorful output.

## Snapper

nkiss makes a few tweaks in `/etc/snapper/configs`:
```
TIMELINE_LIMIT_HOURLY="8"
TIMELINE_LIMIT_DAILY="7"
TIMELINE_LIMIT_WEEKLY="0"
TIMELINE_LIMIT_MONTHLY="0"
TIMELINE_LIMIT_YEARLY="0"
```
1 snapshot per hour, at most 8 hours old
1 snapshot per day, at most 7 days old

weekly, monthly and yearly snapshots are disabled as we think those should be done intentionally, not automatically

Lastly, `limine-snapper-sync` systemd service gets enabled for the Btrfs snapshots functionality using Snapper .
`systemctl enable --now limine-snapper-sync.service`

## Plymouth 

Everything is in `/usr/share/plymouth/themes/nkiss/` containing the images and theme file  (`nkiss.script`) for customizing the splashscreen.

because pretty
also we don't know what/why the consoleFont stuff does in `nkiss.plymouth` 


## Uncomplicated Firewall

nkiss just enables the systemd service with:
 `sudo ufw enable`

Note that this will inhibit ssh, smb, etc. All of those need to be explicitly allowed.

## Limine

nkiss overwrites limine config files created after the (recommended) archinstall.
`/etc/default/limine` (settings regarding limine functionality) should look like this:
```
TARGET_OS_NAME="nkiss"
ESP_PATH="/boot"

ENABLE_UKI=yes
CUSTOM_UKI_NAME="nkiss"

BOOT_ORDER="*, *fallback, Snapshots"

KERNEL_CMDLINE[default]="$CMDLINE"
KERNEL_CMDLINE[default]+="quiet splash"

FIND_BOOTLOADERS=yes
ENABLE_LIMINE_FALLBACK=yes

MAX_SNAPSHOT_ENTRIES=5
SNAPSHOT_FORMAT_CHOICE=4
```

Settings regarding theming/looks of limine are in `/boot/limine.conf` like this:
```
hash_mismatch_panic: no

timeout: 3
interface_branding: nkiss
interface_branding_color: 5
default_entry: 2

backdrop: 232136

term_background: 2a273f
term_foreground: e0def4
term_palette: 6e6a86;eb6f92;f6c177;ea9a97;3e8fb;c4a7e70;9ccfd8;908caa

term_background_bright: f2e9e1
term_foreground_bright: 575279
term_palette_bright: cecacda;b4637a;ea9d34;d7827e;286983;907aa9;56949f;dfdad9
```

Note that `timeout` can be set to `0` in case you want limine to immediately choose the default boot option.


## Simple Desktop Display Manager

 nkiss creates a `niri.desktop` file in `/usr/share/wayland-sessions/` so that SDDM can launch a niri session.
 
 It also sets up autologin in `/etc/sddm.conf.d/autologin.conf` so that you don't need to login to both Plymouth AND SDDM, just Plymouth.
 
 after that it just enables the systemd service:
 `systemctl enable sddm.service`


## Hardware Packages

In case of an nvidia gpu, nkiss will also enable these:
```
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
```
to ensure no freezes/crashes happen on suspend/resume.






Full System?
============

You'll still need essentials! This is not a full modern system.

> [!TIP] Check out [nfluff](https://codeberg.org/nerdwave-nick/nfluff), our own spin on it
