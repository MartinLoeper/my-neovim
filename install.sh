#!/usr/bin/env bash

curl -o /tmp/devbox-installer.sh -L https://get.jetify.com/devbox
chmod u+x /tmp/devbox-installer.sh
/tmp/devbox-installer.sh -f
rm /tmp/devbox-installer.sh

echo "export LC_ALL=en_US.UTF-8" >> ~/.zshrc
sh <(curl -L https://nixos.org/nix/install) --no-daemon
devbox install
devbox run install
