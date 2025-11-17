echo_i ":: enabling mkinitcpio hooks"

if [ -f /usr/share/libalpm/hooks/90-mkinitcpio-install.hook.disabled ]; then
  sudo mv /usr/share/libalpm/hooks/90-mkinitcpio-install.hook.disabled /usr/share/libalpm/hooks/90-mkinitcpio-install.hook
  echo_g "/usr/share/libalpm/hooks/90-mkinitcpio-install.hook.disabled moved to /usr/share/libalpm/hooks/90-mkinitcpio-install.hook"
fi

if [ -f /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook.disabled ]; then
  sudo mv /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook.disabled /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook
  echo_g "/usr/share/libalpm/hooks/60-mkinitcpio-remove.hook.disabled moved to /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook"
fi

echo_s "mkinitcpio hooks re-enabled"

