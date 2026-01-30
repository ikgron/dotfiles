# this will work with any debian based system

# librewolf: run all 3 to install, last 2 to update
sudo apt update && sudo apt install extrepo -y

sudo extrepo enable librewolf && sudo extrepo update librewolf

sudo apt update && sudo apt install librewolf -y
