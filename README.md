# Dotfile Repo

Much has been archived as it is no longer useful

# AI commit style

>AI: are commits from human user to ai work area; ofter instructions in readme to run

AI<: are commits made by ai.

ai should edit readme and checkbox off completed task

# Nym's goal

create auto install script:
 - [x] ask if starship is wanted
    - [x] if yes, install starship and symlink in starship config
    - [x] add starship config to repo
    -   as in commit the starship.toml to dotfiles/surface
 - [x] asks if you want to apt install additional packages
   - explained in cowork: flush_group() calls confirm() once per [group] block
   - [x] the script should ask for each grouping if its wanted.
     - flush_group() is called each time a new [header] is hit while parsing
   - [x] groups should be in the config list file to keep script modifiable

