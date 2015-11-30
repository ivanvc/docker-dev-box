#!/bin/bash

sudo -u dev -H /bin/bash -c 'ruby -e "$(curl -fsSL https://raw.github.com/ivanvc/autoparts/master/setup.rb)"'
sudo mkdir -p /home/action
sudo chown -R dev:dev /home/action
sudo -u dev ln -s /home/dev/.parts /home/action/.parts
