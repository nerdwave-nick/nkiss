echo ""
echo_i ":: setting up limine and automatic login and snapshots"

echo_g ":: grabbing limine config path"
# grab limine config path
if [[ -f /boot/EFI/BOOT/limine.conf ]]; then
  limine_config="/boot/EFI/BOOT/limine.conf"
elif [[ -f /boot/EFI/limine/limine.conf ]]; then
  limine_config="/boot/EFI/limine/limine.conf"
else
  limine_config="/boot/limine.conf"
fi
if [[ ! -f $limine_config ]]; then
  shitpost_error "limine config file not found, get outta me swamp"
fi

echo_g ":: grabbing default limine cmdline"
CMDLINE=$(grep "^[[:space:]]*cmdline:" "$limine_config" | head -1 | sed 's/^[[:space:]]*cmdline:[[:space:]]*//')

# this sets up limine and limine-snapper-syrc for nkiss
echo_g ":: overwriting limine config"
sudo tee /etc/default/limine <<EOF >/dev/null
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
EOF

# set up styled limine config and defaults, limine update will take care of the rest
echo_g ":: overwriting limine.conf"
sudo tee /boot/limine.conf <<EOF >/dev/null
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
EOF
 
# Remove the original config file
if  [[ -f "$limine_config" ]]; then
    echo_g ":: removing original limine config"
    sudo rm "$limine_config"
fi

echo_s ":: limine config set up"
