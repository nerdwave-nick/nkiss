# guarantees setup of encrypted root and btrfs overlayfs, as well as plymouth
echo_i ":: mkinitcpio hooks"
sudo tee /etc/mkinitcpio.conf.d/nkiss_hooks.conf <<EOF >/dev/null
HOOKS=(base udev plymouth keyboard autodetect microcode modconf kms keymap consolefont block encrypt filesystems fsck btrfs-overlayfs)
EOF
echo_s "mkinitcpio hooks set up"
