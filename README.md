# section 1

nkiss is mostly a minimal grab bag of preinstalled packages meant as a kickstarter for a fresh vanilla arch system (in niri), specifically right after an archinstall.

It leaves you with a system that's not supposed to be "complete" or "productive", that system will need tinkering to suit your needs, but it should take fewer steps to get there.

# section 2
⚠️ nkiss relies on a specific archinstall configuration, it will not run otherwise



| Section               | Option                                                                                                                                                                |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Disk configuration    | Partitioning > Default partition layout > btrfs > Use Subvolumes  > Use compression <br><br>Disk Encryption > Encryption type > LUKS<br><br>Btrfs snapshots > Snapper |
| Bootloader            | limine                                                                                                                                                                |
| Authentication        | User account > Add a user (with sudo)                                                                                                                                 |
| Applications          | Audio > pipewire                                                                                                                                                      |
| Network configuration | Copy ISO network config                                                                                                                                               |
| Additional Packages   | git, curl                                                                                                                                                             |

Reboot once the installation is complete

⚠️ Additionally nkiss will NOT run if:
- The system has BIOS instead of UEFI
- Is non-vanilla arch like CachyOS or Garuda
- Running as root
- Gnome or KDE Plasma is installed 

then git clone this 

# Full System?
You'll still need essentials! This is not a full modern system. 
> [!TIP]
> Check out [nfluff](https://codeberg.org/nerdwave-nick/nfluff), our own spin on it
