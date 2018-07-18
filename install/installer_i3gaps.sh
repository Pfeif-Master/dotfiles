sudo add-apt-repository ppa:aguignard/ppa
sudo apt-get update
# dependices
sudo apt-get install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev -y

#from https://github.com/Airblader/i3/wiki/Compiling-&-Installing#debian-stretch:
# clone the repository
git clone https://www.github.com/Airblader/i3 ~/i3-gaps
cd ~/i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
#</>

#Transparent terminal
sudo apt-get install compton nitrogen -y

#demenu
sudo apt-get install dmenu -y

#monitors
sudo apt-get install arandr -y

#GDK
sudo apt-get install lxappearance -y

#terminal
sudo apt-get install terminator -y

#polybar
wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
sudo apt-get update
sudo apt-get install polybar -y

#fix nautilus
	gsettings set org.gnome.desktop.background show-desktop-icons false

#japanese
ibus-setup
