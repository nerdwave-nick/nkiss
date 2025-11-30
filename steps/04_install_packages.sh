echo ""
echo_i ":: installing minimal packages"
echo_g ":: installing pacman packages"
install_from_file dependencies.sh
echo_g ":: installing aur packages"
install_from_file_yay dependencies_aur.sh
echo_s ":: minimal packages installed"
