FROM ubuntu-upstart:trusty
MAINTAINER Ivan Valdes <ivan@vald.es>

ENV LOCAL_USERNAME dev

# Disable root password
RUN passwd -l root

# Install essential tools
RUN \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -yy --no-install-recommends build-essential checkinstall cmake gdb curl wget screen tmux zsh ack-grep gnupg bzip2 zip unzip man-db sqlite3 bison gawk telnet psmisc git git-svn mercurial bzr subversion libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libxml2-dev libxslt1-dev libbz2-dev libncurses5-dev libncursesw5-dev libsqlite3-dev libffi-dev vim-nox && \
  apt-get clean

# Create user and give sudo
RUN \
  /bin/bash -c \
    'useradd --create-home -s /bin/bash $LOCAL_USERNAME && \
    adduser $LOCAL_USERNAME sudo && \
    mkdir -p /etc/sudoers.d && \
    echo $LOCAL_USERNAME ALL=NOPASSWD:ALL > /etc/sudoers.d/$LOCAL_USERNAME && \
    chmod 0440 /etc/sudoers.d/$LOCAL_USERNAME && \
    touch /home/$LOCAL_USERNAME/.zshrc && \
    sudo chsh -s /bin/zsh $LOCAL_USERNAME'

RUN \
  mkdir -p /mhnd/init /mhnd/initonce && \
  touch /mhnd/dont_delete_this_dir

RUN \
  rm /etc/legal && \
  rm /etc/update-motd.d/10-help-text

ADD files/motd /etc/update-motd.d/00-header
ADD files/bootstrap.sh /mhnd/bootstrap.sh
ADD files/sshd_config /etc/ssh/sshd_config

ADD files/initonce/0010-init-ssh.sh /mhnd/initonce/0010-init-ssh.sh

CMD ["/sbin/init", "--default-console", "none"]
