#Refresh sym links
python3 ../snakePit/linker.py ../config/ ~/.config r
python3 ../snakePit/linker.py ../surface/ ~ r

RETURN=$PWD

#Install additional software
sudo apt install terminator -y
sudo apt install compton -y
sudo apt install arandr -y
sudo apt install dmenu -y
# sudo apt install mpd -y
sudo apt install pavucontrol -y
sudo apt install lxappearance -y
sudo apt install fonts-takao-pgothic -y

#dependencies
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
    libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
    libstartup-notification0-dev libxcb-randr0-dev \
    libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
    libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
    autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev -y

#from https://github.com/Airblader/i3/wiki/Compiling-&-Installing#debian-stretch:
# clone the repository
git clone https://www.github.com/Airblader/i3 ~/install_repos/i3-gaps
cd ~/install_repos/i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

cd $RETURN

#fix nautilus
gsettings set org.gnome.desktop.background show-desktop-icons false

#siji font
sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf
git clone https://github.com/stark/siji.git ~/install_repos/siji
cd ~/install_repos/siji
./install.sh -d ~/.fonts
sudo fc-cache -f -v

#polybar
sudo apt install cmake cmake-data libcairo2-dev libxcb1-dev \
    libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev \
    libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto \
    libxcb-xrm-dev libasound2-dev libmpdclient-dev libiw-dev \
    libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2 -y

git clone https://github.com/jaagr/polybar.git ~/install_repos/polybar
cd ~/install_repos/polybar
./build.sh

cd ~/.config/polybar
ln -s default.sh launch

cd $RETURN

#=Better Lock===================================================================
./installer_betterlock.sh

#japanese
# ibus-setup
