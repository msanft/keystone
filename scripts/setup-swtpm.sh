#!/bin/sh

# check if swtpm path exists
if [ ! -f /swtpm ]; then
    echo "swtpm not found, cloning from remote"
    git clone https://github.com/stefanberger/swtpm
fi

# build swtpm
sudo apt-get install dh-autoreconf libssl-dev \
     libtasn1-6-dev pkg-config libtpms-dev \
     net-tools iproute2 libjson-glib-dev \
     libgnutls28-dev expect gawk socat \
     libseccomp-dev make libtasn1-devel -y

cd swtpm

./autogen.sh --with-openssl --prefix=/usr

make -j4

# tests
make -j4 check

sudo make install
