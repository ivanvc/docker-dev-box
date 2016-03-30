#!/bin/bash

# generate new host keys
if [[ ! -f /mhnd/ssh/ssh_host_rsa_key ]] ; then
  rm -rf /etc/ssh/ssh_host_*
  ssh-keygen -A > /dev/null
  mv /etc/ssh/ssh_host_* /mhnd/ssh
fi

# generate user's ssh key
if [[ ! -d /home/dev/.ssh ]] ; then
  mkdir /home/dev/.ssh
  chmod 0700 /home/dev/.ssh
  ssh-keygen -b 2048 -t rsa -N '' -C '' -f /home/dev/.ssh/id_rsa > /dev/null
  curl "https://github.com/$GITHUB_USERNAME.keys" > /mhnd/ssh/authorized_keys
  chown -R dev:dev /home/dev/.ssh
fi
