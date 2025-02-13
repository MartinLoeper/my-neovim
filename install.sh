#!/usr/bin/env bash

curl -o /tmp/devbox-installer.sh -L https://get.jetify.com/devbox
chmod u+x /tmp/devbox-installer.sh
/tmp/devbox-installer.sh -f
rm /tmp/devbox-installer.sh

pwd
devbox install
