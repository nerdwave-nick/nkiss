echo
echo_i ":: configuring pacman"
# Search for the line containing "ParallelDownloads = 5"
line=$(grep "ParallelDownloads = 5" /etc/pacman.conf)

# Check if the line starts with a '#' character
if [[ $line == \#* ]]; then
    # Remove the '#' character from the beginning of the line
    new_line=$(echo "$line" | sed 's/^#//')
    # Replace the original line with the new line in the configuration file
    sudo sed -i "s/$line/$new_line/g" /etc/pacman.conf

    # Display a message indicating that the line was modified
    echo_s ":: parallel downloads enabled"
else
    # Check if the line is already uncommented
    if [[ $line == ParallelDownloads\ =\ 5 ]]; then
        # Display a message indicating that the line does not need to be modified
        echo_g ":: pacman.conf already optimized for parallel downloads."
    else
        sudo echo "ParallelDownloads = 5" >> /etc/pacman.conf
        echo_s ":: parallel downloads enabled"
    fi
fi

echo_i ":: activating color"
if grep -Fxq "#Color" /etc/pacman.conf
then
    sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
    echo_s ":: color activated"
else
    echo_g ":: color is already activated"
fi
if grep -Fxq "# Color" /etc/pacman.conf
then
    sudo sed -i 's/^# Color/Color/' /etc/pacman.conf
    echo_s ":: color activated in pacman.conf"
fi
echo_s ":: pacman configured"
