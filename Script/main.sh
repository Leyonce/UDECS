#!/bin/bash
# Ubuntu Configuration script
# This is the main script that will call all the other files that I might have in the future.
# It installs my defaults java, postgres, mysql.
# Afterwards it calls on secondary configuration modules like that for Idempiere, Ionic 
#Written by Eyog Yvon Léonce
clear
echo '#------------------------------------#'
echo '#   EYL Ubuntu Configuration Script  #'
echo '#------------------------------------#'
echo ''
####Function declerations 
getPassword (){  
	read prompt1
	if [ $prompt1 == 'yes' ];  
	then 
		stty -echo
		printf " Enter your password: "
		read PASSWORD
		stty 
		echo
		printf "\n"
	else
		echo "Bye Bye"
	fi
}

addRepositories(){
#add repositories
echo 'Adding repositories'
echo -e $PASSWORD | sudo -S add-apt-repository -y ppa:webupd8team/java

} 

update(){
echo '\n Updating...'
echo -e $PASSWORD | sudo -S apt-get update
}

mysql(){
#install and set root password of mysql
echo -e $PASSWORD | sudo -S debconf-set-selections <<< 'mysql-server mysql-server/root_password password $PASSWORD'
echo -e $PASSWORD | sudo -S debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password $PASSWORD'
echo -e $PASSWORD | sudo -S apt-get -y install mysql-server -y --force-yes
#configure mysql
echo 'Mysql config ...'
echo -e $PASSWORD | sudo -S mysql_install_db;
echo -e $PASSWORD | sudo -S /usr/bin/mysql_secure_installation
echo 'End Mysql config ...'

echo -e $PASSWORD | sudo -S source development/installphpmyadmin.sh
}

installPackages(){
#install packages
echo -e $PASSWORD | sudo -S apt-get install python-software-properties default-jre default-jdk openjdk-7-jre openjdk-7-jdk oracle-java6-installer oracle-java7-installer oracle-java8-installer oracle-java7-set-default    libpg-java  git mercurial  -y --force-yes
clear
}

setKeyboardLayout(){
#Set this changes the keyboard layout to match my hp envy
clear
echo "Setting keyboardLayout config"
echo -e $PASSWORD | sudo -S cp /dev/null /usr/share/X11/xkb/symbols/us
echo -e $PASSWORD | sudo -S cp configuration/keyboardConfiguration /usr/share/X11/xkb/symbols/us 
}


postgres(){
#install postgres
echo -e $PASSWORD | sudo -S apt-get install postgresql postgresql-contrib pgadmin3 -y --force-yes
#configure database
echo 'Postgres password'

#echo "\password postgres" | sudo -u postgres psql postgres
echo -e $PASSWORD | sudo -S -u postgres psql -c "ALTER USER postgres WITH PASSWORD '{adempiere}';" 
echo -e $PASSWORD | sudo -S -u postgres psql postgres -c "CREATE EXTENSION adminpack"
echo -e $PASSWORD | sudo -S sed -i 's/local   all             postgres                                peer/local   all             postgres                                md5/' /etc/postgresql/9.5/main/pg_hba.conf

echo -e $PASSWORD | sudo -S /etc/init.d/postgresql reload
}

developmentConfiguration(){
source development/android.sh
source development/ionic.sh
source development/idempiere.sh
}

intelPowerClamp(){
echo -e $PASSWORD | sudo -S rmmod intel_powerclamp
cd /etc/modprobe.d
echo -e $PASSWORD | sudo -S echo install intel_powerclamp /bin/true  >intel_powerclamp.conf
}
######### Main program
echo "This script requires you to set your password and relax. Do you want to continue?"
getPassword
setKeyboardLayout
addRepositories
update
installPackages
mysql
postgres
developmentConfiguration
intel_powerclamp
#else my_pass is empty
