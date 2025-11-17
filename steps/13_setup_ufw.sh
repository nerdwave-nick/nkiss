echo ""
echo_i ":: setting up ufw"

# this will inhibit ssh, smb, etc. All of those need to be explicitly allowed.
echo_g ":: enabling ufw with default settings (this will deny everything incoming)"
sudo ufw enable

echo_s ":: ufw set up"
