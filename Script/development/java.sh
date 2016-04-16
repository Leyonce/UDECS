#!/bin/bash
#Setting the java ENV variable and the default java used in the system
update() {
sudo apt-get update
}

install() {
    sudo apt-get install default-jdk -y
    sudo apt-get install default-jre -y
	sudo apt-get install openjdk-7-jre -y
    sudo apt-get install openjdk-7-jdk -y 
	sudo apt-get install python-software-properties -y
    
	}
addRepositories() {
sudo add-apt-repository ppa:webupd8team/java -y
}

installOracle(){
    sudo apt-get install oracle-java6-installer -y
    sudo apt-get install oracle-java7-installer -y
    sudo apt-get install oracle-java8-installer -y
}

setDefault(){
sudo update-alternatives --set java /usr/lib/jvm/java-7-oracle/jre/bin/java
}

update 
install
addRepositories
installOracle
setDefault