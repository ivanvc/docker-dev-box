#!/bin/bash

# generate new host keys
rm -rf /etc/ssh/ssh_host_*
ssh-keygen -A > /dev/null
# generate user's ssh key
mkdir /home/$LOCAL_USERNAME/.ssh
chmod 0700 /home/$LOCAL_USERNAME/.ssh
ssh-keygen -b 2048 -t rsa -N '' -C '' -f /home/$LOCAL_USERNAME/.ssh/id_rsa > /dev/null
curl "https://github.com/$GITHUB_USERNAME.keys" > /home/$LOCAL_USERNAME/.ssh/authorized_keys
chown -R $LOCAL_USERNAME:$LOCAL_USERNAME /home/$LOCAL_USERNAME/.ssh
