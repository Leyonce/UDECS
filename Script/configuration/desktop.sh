#Adds Desktop environment
#Adds cinanmon
addRepository(){
sudo add-apt-repository ppa:moorkai/cinnamon -y
}

update() {
sudo apt-get update
}

install(){
sudo apt-get install cinnamon -y 
 }
 
 addRepository
 update
 install