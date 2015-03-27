#!/bin/bash

sudo -u $LOCAL_USERNAME -H /bin/bash -c 'ruby -e "$(curl -fsSL https://raw.github.com/ivanvc/autoparts/master/setup.rb)"'
sudo mkdir -p /home/action
sudo chown -R dev:dev /home/action
sudo -u $LOCAL_USERNAME ln -s /home/dev/.parts /home/action/.parts
