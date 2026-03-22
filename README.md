# Dotfile Repo

Much has been archived as it is no longer useful

# AI commit style

>AI: are commits from human user to ai work area; ofter instructions in readme to run

AI<: are commits made by ai.

ai should edit readme and checkbox off completed task

# Nym's goal

create auto install script:
 - [x] replaces ~/ items with softlink to ~/dotfile/surface.
 - [x] if there was an original dot file on system, copy it into ~/.orginal_dots
before making the symlink
 - [x] clone vundle into vim
 - [x] ask if starship is wanted
    - [x] if yes, install starship and symlink in starship config
    - [x] add starship config to repo
 - [x] asks if you want to apt install additional packages
   - [x] lets have the script pull packages to install from a config list file in this repo
   - [x] the script should ask for each grouping if its wanted.
   - [x] groups should be in the config list file to keep script modifiable
   - [x] initial groups to add
     - [x] python rich
     - [x] dependencies to finish installing ycm with c and rust family completions

