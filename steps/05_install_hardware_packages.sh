echo ""
echo_i ":: trying to install cpu/gpu related packages"

echo_g ":: detecting hardware and selecting packages"

packages=$(python3 ./packages/hardware_packages.py)

if [ -z "$packages" ]; then
    echo_s ":: no hardware packages found"
else
    install_with_pacman "$packages"

    echo_g ":: hardware packages installed"

    # nvidia specific stuff if needed
    if pacman -Qi nvidia-utils &> /dev/null; then
        echo_g ":: setting up nvidia services"

        # Essential for sleep/suspend to work without crashing
        sudo systemctl enable nvidia-suspend.service
        sudo systemctl enable nvidia-hibernate.service
        sudo systemctl enable nvidia-resume.service
    fi

    echo_s ":: hardware packages setup complete"
fi
