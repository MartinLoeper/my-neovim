#!/usr/bin/env bash

curl -o /tmp/devbox-installer.sh -L https://get.jetify.com/devbox
chmod u+x /tmp/devbox-installer.sh
/tmp/devbox-installer.sh -f
rm /tmp/devbox-installer.sh

devbox global add home-manager
refresh-global
echo 'eval "$(devbox global shellenv --init-hook)"' >> ~/.zshrc
echo "export LC_ALL=en_US.UTF-8" >> ~/.zshrc

