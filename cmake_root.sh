#!/bin/sh

version=$1
origdir=`dirname $0`

# Set compiler variables (add version, e.g. "-5", "-6", to override)
CC=gcc
CXX=g++

echo "Downloading root_v${version}.source.tar.gz..."
until test -f root_v${version}.source.tar.gz
do wget http://root.cern.ch/download/root_v${version}.source.tar.gz
done

echo "Unpacking root_${version}.source.tar.gz..."
until test -d root-${version}
do
  tar -zxvf root_v${version}.source.tar.gz
  mv root root-${version}
done

mkdir -p root-${version}-build
cd root-${version}-build

echo "Configuring root.${version}..."
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \
 -DCMAKE_INSTALL_PREFIX=/usr/local/root/root.${version} \
 -DCMAKE_CXX_STANDARD=17 \
 -Dall=ON \
 ../root-${version}

j=`cat /proc/cpuinfo | grep processor | wc -l`
echo "Make will use $j parallel jobs."

echo "Building root.${version}..."
make -j $j -k

echo "Installing root.${version}..."
make -j $j install

cd "${origdir}"

