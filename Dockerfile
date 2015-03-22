FROM ubuntu-upstart:trusty
MAINTAINER Ivan Valdes <ivan@vald.es>

ENV LOCAL_USERNAME dev

# Disable root password
RUN passwd -l root

# Install essential tools
RUN \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -yy --no-install-recommends automake autotools-dev \
  base-files base-passwd binutils build-essential bzip2 cmake curl \
  dnsutils gdb git git-core gnupg imagemagick libarchive-dev \
  libbz2-1.0 libbz2-dev libc6 libcurl3 libcurl3-gnutls libcurl4-openssl-dev \
  libdb5.1 libdb5.1-dev libevent-1.4-2 libevent-core-1.4-2 libevent-dev \
  libevent-extra-1.4-2 libffi-dev libgdbm-dev libglib2.0-dev libglib2.0-dev \
  libicu-dev libldap-2.4-2 libldap2-dev libltdl-dev libltdl7 liblzma-dev \
  liblzma-doc liblzma5 libmagickcore-dev libmagickwand-dev libmysqlclient-dev \
  libncap-dev libncap44 libncurses5-dev libncurses5-dev libncursesw5 \
  libncursesw5-dev libpam0g-dev libpng12-0 libpng12-dev libpq-dev libqt4-dev \
  libreadline6-dev libsndfile1-dev libsqlite3-dev libssl0.9.8 libxml2 \
  libxml2-dev libxslt1-dev libxt-dev libxt6 libyaml-dev openssl psmisc \
  ruby1.9.3 s3cmd sqlite3 telnet tsconf unzip util-linux wget whiptail \
  xz-utils zip zlib1g zlib1g-dev && \
  apt-get clean

# Create user and give sudo
# adduser $LOCAL_USERNAME sudo && \
# mkdir -p /etc/sudoers.d && \
# echo $LOCAL_USERNAME ALL=NOPASSWD:ALL > /etc/sudoers.d/$LOCAL_USERNAME && \
# chmod 0440 /etc/sudoers.d/$LOCAL_USERNAME && \
# zsh
# touch /home/$LOCAL_USERNAME/.zshrc && \
#   chsh -s /bin/zsh $LOCAL_USERNAME'

RUN /bin/bash -c  'useradd --create-home -s /bin/bash $LOCAL_USERNAME'

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
ADD files/initonce/0050-init-autoparts.sh /mhnd/initonce/0050-init-autoparts.sh

RUN apt-get source update-motd

CMD ["/sbin/init", "--default-console", "none"]
