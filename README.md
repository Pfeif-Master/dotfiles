```bash
sudo apt install git
#if you want website repo than add key to git lab
ssh-keygen -t rsa -C "your.email@example.com" -b 4096
sudo apt install xclip
xclip -sel clip ~/.ssh/id_rsa.pub
#test auto install linker section
#should also verify that the scripts in ./install are to
#your liking
./autoInstall.sh -t
#run auto install 
./autoInstall.sh -r
```
