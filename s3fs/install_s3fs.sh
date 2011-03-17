#!/bin/bash
PWD=$(cd $(dirname $0);pwd)
sudo apt-get install -y libxml2-dev libcurl4-openssl-dev
mkdir -p tmp.s3fs
cd tmp.s3fs

#install fuse
echo -n "install fuse"
wget "http://downloads.sourceforge.net/project/fuse/fuse-2.X/2.8.5/fuse-2.8.5.tar.gz"
tar xvf fuse-2.8.5.tar.gz
cd fuse-2.8.5
./configure && make && sudo make install
cd ../
echo

#install s3fs
echo -n "install s3fs"
wget "http://s3fs.googlecode.com/files/s3fs-1.40.tar.gz"
tar xvf s3fs-1.40.tar.gz
cd s3fs-1.40
./configure && make && sudo make install
sudo modprobe fuse
cd ../
echo
cd ../
rm -rf tmp.s3fs

#install config
echo -n "install s3fs config"
sudo cp ${PWD}/passwd-s3fs /etc/passwd-s3fs
sudo chown www-data:www-data /etc/passwd-s3fs
sudo chmod 600 /etc/passwd-s3fs
sudo cp ${PWD}/s3fs-www.conf /etc/init/s3fs-www.conf
echo
echo "start s3fs"
sudo start s3fs-www
