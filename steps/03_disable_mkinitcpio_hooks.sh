# speeds up installation
echo_i ":: temporarily disabling mkinitcpio hooks during installation"

# move to backup file if they exist
if [ -f /usr/share/libalpm/hooks/90-mkinitcpio-install.hook ]; then
  sudo mv /usr/share/libalpm/hooks/90-mkinitcpio-install.hook /usr/share/libalpm/hooks/90-mkinitcpio-install.hook.disabled
  echo_g "/usr/share/libalpm/hooks/90-mkinitcpio-install.hook moved to /usr/share/libalpm/hooks/90-mkinitcpio-install.hook.disabled"
fi

if [ -f /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook ]; then
  sudo mv /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook.disabled
  echo_g "/usr/share/libalpm/hooks/60-mkinitcpio-remove.hook moved to /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook.disabled"
fi

echo_s "mkinitcpio hooks disabled"
