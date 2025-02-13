#!/usr/bin/env bash

curl -o /tmp/devbox-installer.sh -L https://get.jetify.com/devbox
chmod u+x /tmp/devbox-installer.sh
/tmp/devbox-installer.sh -f
rm /tmp/devbox-installer.sh

devbox global install
echo ". /home/vscode/.nix-profile/etc/profile.d/nix.sh" >> /home/vscode/.zshrc

