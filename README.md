section 1
=========

nkiss is mostly a minimal grab bag of preinstalled packages meant as a kickstarter for a fresh vanilla arch system (in niri), specifically right after an archinstall.

It leaves you with a system that's not supposed to be "complete" or "productive", that system will need tinkering to suit your needs, but it should take fewer steps to get there.

Hardware setup is documented here [DRIVERS.md](docs/DRIVERS.md)

section 2
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

Full System?
============

You'll still need essentials! This is not a full modern system.

> [!TIP] Check out [nfluff](https://codeberg.org/nerdwave-nick/nfluff), our own spin on it
