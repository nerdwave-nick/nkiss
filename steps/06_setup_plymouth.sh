echo ""
echo_i ":: setting up plymouth"

if [ "$(plymouth-set-default-theme)" != "nkiss" ]; then
  sudo cp -r "$NKISS_PATH/data/plymouth" /usr/share/plymouth/themes/nkiss/
  sudo plymouth-set-default-theme nkiss
fi

echo_s ":: plymouth set up"
