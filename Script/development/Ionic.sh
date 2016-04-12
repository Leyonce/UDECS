#!/bin/bash
#This script connfigures everything around Ionic framework
NodeJS(){
#installing and configuring NodeJS
echo -e $PASSWORD | sudo -S apt-get install python-software-properties -y --force-yes
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -

{sleep 3} echo -e $PASSWORD | sudo -S apt-get install nodejs -y --force-yes

}

ionic(){
echo -e $PASSWORD | sudo -S apt-get install lib32z1 lib32ncurses5 lib32bz2-1.0
echo -e $PASSWORD | sudo -S npm install -g cordova
echo -e $PASSWORD | sudo -S npm install -g ionic
}

NodeJS
ionic

