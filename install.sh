#!/bin/bash
# exit on error
set -eEo pipefail

NKISS_PATH="$(realpath "$(dirname "$0")")"
cd "$NKISS_PATH" || exit


source ./lib/colors.sh
source ./lib/errors.sh
source ./lib/install_packages.sh

clear
source ./lib/logo.sh

source ./steps/00_check_compatibility.sh
source ./steps/01_install_deps.sh
source ./steps/02_disable_mkinitcpio_hooks.sh
source ./steps/03_configure_pacman.sh
source ./steps/04_install_packages.sh
source ./steps/05_install_hardware_packages.sh
source ./steps/06_setup_plymouth.sh
source ./steps/07_setup_sddm.sh
source ./steps/08_setup_nkiss_mkinitcpio_hooks.sh
source ./steps/09_setup_boot_and_login.sh
source ./steps/10_setup_snapshots.sh
source ./steps/11_reactivate_mkinitcpio_hooks.sh
source ./steps/12_update_limine.sh
source ./steps/13_setup_ufw.sh

echo ""
source ./lib/logo.sh
echo_s ":: nkiss installation is complete!"
echo_s ":: please reboot to apply changes"
