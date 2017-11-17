#!/usr/bin/env bash
# This script installs PhantomJS on your Linux System
#
# This script must be run as root:
# sudo sh install_phantomjs.sh
#

set -eu

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

OFFLINE=${2:-""}

VERSION=${1:-"1.9.8"}
PHANTOM_VERSION="phantomjs-$VERSION"
ARCH=$(uname -m)

if ! [ "$ARCH" = "x86_64" ]; then
    ARCH="i686"
fi

PHANTOM_JS="$PHANTOM_VERSION-linux-$ARCH"

#DISTRIBUTION=$(cat /etc/issue | cut -d ' ' -f 1)
#if [[ $DISTRIBUTION == "Ubuntu" ]]

if [ -f /etc/redhat-release ]; then
    yum install freetype freetype-devel -y
    yum install fontconfig fontconfig-devel -y
fi

if [ -f /etc/lsb-release ]; then
    sudo apt-get update
    sudo apt-get install build-essential chrpath libssl-dev libxft-dev -y
    sudo apt-get install libfreetype6 libfreetype6-dev -y
    sudo apt-get install libfontconfig1 libfontconfig1-dev -y
fi

cd /tmp
if ! [ "$OFFLINE" = "--offline" ]; then
    wget "https://bitbucket.org/ariya/phantomjs/downloads/${PHANTOM_JS}.tar.bz2"
fi
sudo tar xvjf "/tmp/${PHANTOM_JS}.tar.bz2"

sudo cp -a "/tmp/$PHANTOM_JS" /usr/local/share/ && sudo rm -r "/tmp/$PHANTOM_JS"
sudo ln -sf "/usr/local/share/${PHANTOM_JS}/bin/phantomjs" /usr/local/bin
sudo ln -sf /usr/local/bin/phantomjs /usr/bin/phantomjs
