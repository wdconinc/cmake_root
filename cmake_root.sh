#!/bin/sh

version=$1
origdir=`dirname $0`

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
 -DCMAKE_CXX_FLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" \
 -DCMAKE_INSTALL_PREFIX=/usr/local/root/root.${version} \
 -Dall=ON \
 -Dgeocad=ON -DOCC_INCLUDE_DIR=/usr/include/oce \
 -Dgdml=ON -Dminuit=ON -Dminuit2=ON -Dmathmore=ON \
 -Dpython=ON -DPYTHON_EXECUTABLE=/usr/bin/python3 \
 -Dr=OFF \
 ../root-${version}

j=`cat /proc/cpuinfo | grep processor | wc -l`
echo "Make will use $j parallel jobs."

echo "Building root.${version}..."
make -j $j -k

echo "Installing root.${version}..."
make -j $j install

cd "${origdir}"

