echo ""
echo_i ":: setting up sddm"

echo_g ":: ensuring sddm config dir exists"
sudo mkdir -p /etc/sddm.conf.d

echo_g ":: set up desktop file for niri"
sudo mkdir -p /usr/share/wayland-sessions
if [ ! -f /usr/share/wayland-sessions/niri-uwsm.desktop ]; then
  sudo tee /usr/share/wayland-sessions/niri-uwsm.desktop >/dev/null <<'DESKTOP'
[Desktop Entry]
Name=Niri UWSM 
Comment=Start Niri via UWSM
Exec=uwsm start -- niri --session
Type=Application
DesktopNames=niri
DESKTOP
fi

echo_g ":: setting up sddm autologin"
if [ ! -f /etc/sddm.conf.d/autologin.conf ]; then
  cat <<EOF | sudo tee /etc/sddm.conf.d/autologin.conf
[Autologin]
User=$USER
Session=niri-uwsm

[Theme]
Current=breeze
EOF
fi

echo_g ":: enabling sddm service"
sudo systemctl enable sddm.service

echo_s ":: sddm set up"
