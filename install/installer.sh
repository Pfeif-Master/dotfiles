#!/bin/sh
#update system
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
#most used programs 
sudo apt-get install vim-gnome -y
sudo apt-get install tmux -y
sudo apt-get install tmuxinator -y
sudo apt-get install htop -y
sudo apt-get install xournal -y
sudo apt-get install python3-pip -y #python
sudo pip3 install --upgrade pip
#powerline
sudo pip3 install git+git://github.com/Lokaltog/powerline
sudo wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
sudo wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf /usr/share/fonts/
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
# mpsyoutube
sudo pip3 install mps-youtube
sudo pip3 install youtube-dl
sudo apt-get install mpv -y 
# YCM
sudo apt-get install build-essential cmake -y
sudo apt-get install python-dev python3-dev -y
# part of color coded, need to the lua part
sudo apt-get install build-essential libclang-3.9-dev libncurses-dev libz-dev cmake xz-utils libpthread-workqueue-dev -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install g++-4.9 -y
sudo update-alternatives --remove-all g++
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 50
#other
sudo apt-get install gsmartcontrol -y #for inspecting SSD helth
sudo apt-get install ibus-anthy -y #for japanese
#apt-get install compizconfig-settings-manager compiz-plugins-extra -y
sudo apt-get install gnome-tweak-tool -y
sudo apt-get install steam -y
#clean up
sudo apt-get autoremove -y
#prep for next step in README
vim --version | grep lua
