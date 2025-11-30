echo ""
echo_i ":: installing yay"

if sudo pacman -Qs yay; then
    echo_s ":: yay is already installed!"
else
    temp_path=$PWD
    echo_g ":: cloning yay.git into temporary location at ~/yay-bin"
    git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin
    cd ~/yay-bin || exit
    echo_g ":: running makepkg -si"
    makepkg -si --needed --noconfirm
    cd "$temp_path" || exit
    echo_g ":: removing temporary git repo"
    rm -rf ~/yay-bin
    echo_s ":: yay installed successfully"
fi

echo_i ":: installing and setting up rustup"
if sudo pacman -Qs rustup; then
    echo_s ":: rustup is already installed!"
else
    sudo pacman -S --noconfirm --needed rustup
    echo_g ":: rustup installed successfully"
    echo_g ":: setting up default toolchain"
    rustup default stable
    echo_s ":: rustup set up"
fi
