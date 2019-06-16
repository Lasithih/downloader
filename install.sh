#!/usr/bin/env bash

sudo apt-get -y update

echo "Installing build tools"
sudo apt-get install -y cmake build-essential


echo "Installing youtube-dl"
sudo apt install -y youtube-dl


echo "Installing log4c"
sudo apt-get install -y liblog4c-dev


echo "Installing mysql client"
sudo apt-get install -y libmysqlclient-dev


echo "Installing libConfig"
sudo apt-get install -y libconfig-dev


echo "Enter mysql server address (eg: localhost)"
read db_server

echo "Enter mysql user (eg: root)"
read db_user

echo "Enter mysql password"
mysql -u $db_user -p << EOF
source support/database.sql
EOF


echo "Building downloader"
sudo mkdir build
cd build
cmake ..
make

echo "Installing..."
mkdir -p $HOME/LIHApps/Downloader
cp Downloader $HOME/LIHApps/Downloader
cp support/config.cfg $HOME/LIHApps/Downloader
cp support/log4crc $HOME/LIHApps/Downloader
cd ..

echo "Enabling service"
sed -i "s~WorkingDirectory=~WorkingDirectory=$HOME/LIHApps/Downloader~" support/downloader.service
sed -i "s~ExecStart=~ExecStart=$HOME/LIHApps/Downloader/Downloader~" support/downloader.service
sudo cp support/downloader.service /lib/systemd/system

sudo systemctl enable downloader.service
sudo systemctl start downloader.service


