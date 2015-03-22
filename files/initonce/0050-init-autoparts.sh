#!/bin/bash

sudo -u $LOCAL_USERNAME -H /bin/bash -c 'ruby -e "$(curl -fsSL https://raw.github.com/nitrous-io/autoparts/master/setup.rb)"'
