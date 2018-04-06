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
    yum install -y  freetype freetype-devel \
                    fontconfig fontconfig-devel
fi

if [ -f /etc/lsb-release ]; then
    apt-get -qq update
    apt-get install -qq -y  build-essential chrpath libssl-dev libxft-dev \
                            libfreetype6 libfreetype6-dev \
                            libfontconfig1 libfontconfig1-dev
fi

cd /tmp
if ! [ "$OFFLINE" = "--offline" ]; then
    wget "https://bitbucket.org/ariya/phantomjs/downloads/${PHANTOM_JS}.tar.bz2"
fi

cd /usr/local/share/
sudo tar xvjf "/tmp/${PHANTOM_JS}.tar.bz2"

sudo ln -sf "/usr/local/share/${PHANTOM_JS}/bin/phantomjs" /usr/local/bin
sudo ln -sf /usr/local/bin/phantomjs /usr/bin/phantomjs
