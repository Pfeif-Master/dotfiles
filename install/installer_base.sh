#!/bin/sh
#update system
sudo apt update
sudo apt upgrade

#most used programs 
sudo apt install vim-gnome -y
sudo apt install tmux -y
sudo apt install tmuxinator -y
sudo apt install htop -y
sudo apt install xournal -y
sudo apt install python3-pip -y #python
sudo pip3 install --upgrade pip
sudo pip3 install colorama
sudo apt install nitrogen -y
sudo apt install neofetch -y
sudo snap install gitkraken
sudo snap install discord
sudo snap install zenkit

# mpsyoutube
sudo pip3 install mps-youtube
sudo pip3 install youtube-dl
sudo apt install mpv -y 

# YCM
sudo apt install build-essential cmake -y
sudo apt install python-dev python3-dev -y
sudo apt install npm -y #optional for js and ts

# zsh
sudo apt install zsh -y
sudo apt install curl -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo chsh -s /bin/zsh

#NOTE use airline plugin instead
#powerline
#sudo apt-get install python3-testresources -y
##sudo pip3 install git+git://github.com/Lokaltog/powerline
#pip install --user git+git://github.com/Lokaltog/powerline
sudo wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
sudo wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf /usr/share/fonts/
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

#other
#sudo apt-get install gsmartcontrol -y #for inspecting SSD helth
#sudo apt-get install ibus-anthy -y #for japanese
# sudo apt-get install ibus-mozc -y #for japanese
sudo apt install fcitx-mozc -y

# sudo apt install gnome-tweak-tool -y
# sudo apt-get install steam -y

#clean up
sudo apt autoremove -y

#=SymLinks=====================================================================
../snakePit/linker.py config/ ~/.config r
../snakePit/linker.py surface/ ~ r

#=GIT==========================================================================
mkdir ~/install_repos
git clone https://github.com/lyze/posh-git-sh.git ~/install_repos #install posh-get
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim #vundle

#=VIM==========================================================================
vim -c 'PluginInstall' -c 'qa'
cd ~/.vim/bundle/YouCompleteMe
python3 ./install.py --clang-completer
cd -
