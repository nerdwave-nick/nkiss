#!/bin/bash

# exit on error
set -eEo pipefail

if [ -d ${HOME}/.local/share/nkiss ]; then
    echo "nkiss is already cloned to ${HOME}/.local/share/nkiss"
    echo ":: remove it first by running"
    echo "        rm -rf ${HOME}/.local/share/nkiss"
    exit 1;
fi

echo ":: cloning nkiss to ${HOME}/.local/share/nkiss"
git clone https://codeberg.org/nerdwave-nick/nkiss ${HOME}/.local/share/nkiss  &> /dev/null

cd ${HOME}/.local/share/nkiss &> /dev/null && ./install.sh
