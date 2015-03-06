#!/bin/bash -eux

UBUNTU_VERSION=`lsb_release -r | awk '{print $2}'`
# on 12.04 work around bad cached lists
if [[ "$UBUNTU_VERSION" == '12.04' ]]; then
  apt-get clean
  rm -rf /var/lib/apt/lists
fi

# apt-get update does not actually perform updates, it just downloads and indexes the list of packages
apt-get -y update

# Upgrade all installed packages incl. kernel and kernel headers
apt-get -y upgrade linux-server linux-headers-server

# ensure the correct kernel headers are installed
apt-get -y install linux-headers-$(uname -r)

# update package index on boot
cat <<EOF > /etc/init/refresh-apt.conf
description "update package index"
start on networking
task
exec /usr/bin/apt-get update
EOF

# on 12.04 manage broken indexes on distro disc 12.04.5
if [[ $UBUNTU_VERSION == '12.04' ]]; then
  apt-get -y install libreadline-dev dpkg
fi

if [[ $UPDATE  =~ true || $UPDATE =~ 1 || $UPDATE =~ yes ]]; then
	echo "==> Updating list of repositories"
    echo "==> Performing dist-upgrade (all packages and kernel)"
    apt-get -y dist-upgrade --force-yes
    reboot
    sleep 60
fi
