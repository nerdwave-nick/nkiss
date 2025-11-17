echo_i ":: checking compatibility"

if [ "$EUID" -eq 0 ]; then
  shitpost_error "running as root? get outta me swamp"
fi

if [[ ! -f /etc/arch-release ]]; then
    shitpost_error "not arch, get outta me swamp"
fi

for marker in /etc/cachyos-release /etc/eos-release /etc/garuda-release /etc/manjaro-release; do
  if [[ -f "$marker" ]]; then
    shitpost_error "not vanilla arch, get outta me swamp"
  fi
done

if pacman -Qe gnome-shell &>/dev/null || pacman -Qe plasma-desktop &>/dev/null; then
    shitpost_error "gnome-shell or plasma-desktop detected, get outta me swamp"
fi

[ "$(findmnt -n -o FSTYPE /)" = "btrfs" ] || shitpost_error "not btrfs, get outta me swamp"

cat /sys/firmware/efi/fw_platform_size &>/dev/null || shitpost_error "not efi boot, get outta me swamp"

if ! command -v efibootmgr &>/dev/null; then
    shitpost_error "efibootmgr not found, get outta me swamp"
fi

if ! command -v limine &>/dev/null; then
    shitpost_error "limine not found, get outta me swamp"
fi

if ! command -v pipewire &>/dev/null; then
    shitpost_error "pipewire not found, get outta me swamp"
fi

if ! command -v git &>/dev/null; then
    shitpost_error "git not found, get outta me swamp"
fi

if ! command -v snapper &>/dev/null; then
    shitpost_error "snapper not found, get outta me swamp"
fi

echo_s ":: compatibility checks passed"
