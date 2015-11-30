#!/bin/bash

# generate new host keys
rm -rf /etc/ssh/ssh_host_*
ssh-keygen -A > /dev/null
# generate user's ssh key
mkdir /home/$LOCAL_USERNAME/.ssh
chmod 0700 /home/dev/.ssh
ssh-keygen -b 2048 -t rsa -N '' -C '' -f /home/dev/.ssh/id_rsa > /dev/null
curl "https://github.com/$GITHUB_USERNAME.keys" > /home/dev/.ssh/authorized_keys
chown -R dev:dev /home/dev/.ssh
