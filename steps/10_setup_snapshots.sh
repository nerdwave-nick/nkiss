echo ""
echo_i ":: setting up snapshots"

echo_g ":: checking for snapper configs"
# ensure root and home configs exists
if ! sudo snapper list-configs 2>/dev/null | grep -q "root"; then
  sudo snapper -c root create-config /
fi

if ! sudo snapper list-configs 2>/dev/null | grep -q "home"; then
  sudo snapper -c home create-config /home
fi

echo_g ":: tweaking snapper configs"
# Tweak default Snapper configs
# reduce number of hourly / daily snapshots to 12 for home
sudo sed -i 's/^TIMELINE_LIMIT_HOURLY="10"/TIMELINE_LIMIT_HOURLY="8"/' /etc/snapper/configs/{root,home}
sudo sed -i 's/^TIMELINE_LIMIT_DAILY="10"/TIMELINE_LIMIT_DAILY="7"/' /etc/snapper/configs/{root,home}

# long term snapshots should be done manually / mindfully. Disable timeline by default here
sudo sed -i 's/^TIMELINE_LIMIT_WEEKLY="10"/TIMELINE_LIMIT_WEEKLY="0"/' /etc/snapper/configs/{root,home}
sudo sed -i 's/^TIMELINE_LIMIT_MONTHLY="10"/TIMELINE_LIMIT_MONTHLY="0"/' /etc/snapper/configs/{root,home}
sudo sed -i 's/^TIMELINE_LIMIT_YEARLY="10"/TIMELINE_LIMIT_YEARLY="0"/' /etc/snapper/configs/{root,home}

echo_g ":: enabling snapper limine sync service"
sudo systemctl enable --now limine-snapper-sync.service

echo_s ":: snapshots set up"
