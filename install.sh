#!/bin/bash
# exit on error
set -eEo pipefail

NKISS_PATH="$(realpath "$(dirname "$0")")"
cd "$NKISS_PATH" || exit


source ./lib/colors.sh
source ./lib/errors.sh
source ./lib/install_packages.sh

source ./steps/00_check_compatibility.sh
source ./steps/01_install_requirements.sh
source ./steps/02_install_yay.sh

source ./lib/logo.sh
gum confirm "Ready to install nkiss? [Y/n]" || exit 0

source ./steps/03_disable_mkinitcpio_hooks.sh
source ./steps/04_configure_pacman.sh
source ./steps/05_install_packages.sh
source ./steps/06_setup_plymouth.sh
source ./steps/07_setup_sddm.sh
source ./steps/08_setup_nkiss_mkinitcpio_hooks.sh
source ./steps/09_setup_boot_and_login.sh
source ./steps/10_setup_snapshots.sh
source ./steps/11_reactivate_mkinitcpio_hooks.sh
source ./steps/12_update_limine.sh
source ./steps/13_setup_ufw.sh

echo_s ":: nkiss installation is complete!"
