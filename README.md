# Dotfile Repo

Much has been archived as it is no longer useful

# AI commit style

>AI: are commits from human user to ai work area; ofter instructions in readme to run

AI<: are commits made by ai.

ai should edit readme and checkbox off completed task

# Nym's goal

create auto install script:
 - replaces ~/ items with softlink to ~/dotfile/surface.
 - - if there was an original dot file on system, copy it into ~/.orginal_dots 
before making the symlink
 - clone vundle into vim
 - ask if starship is wanted
    - if yes, install startship and symlink in starship config
    - add starship config to repo
 - asks if you want to apt install additional packages
   - lets have the script pull packages to install from a config list file in this repo
   - the script should ask for each grouping if its wanted.
   - groups should be in the config list file to keep script modifiable
   - initial groups to add
     - python rich
     - decencies to finish installing ycm with c and rust family completions

