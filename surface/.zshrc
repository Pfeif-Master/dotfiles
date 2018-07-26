YELLOW="[1;33m"
GREEN="[1;32m"
CYAN="[1;36m"
BLUE="[1;34m"
RED="[1;31m"
COLOREND="[m"

#start greeter
#set_color bryellow
echo -ne "${YELLOW}"
cat ~/dotfiles/surface/art1
echo -e "${GREEN}システムスタート${E_COLOREND}"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch
unsetopt appendhistory autocd beep notify
bindkey -v
# End of lines configured by zsh-newuser-install

source ~/posh-git-sh/git-prompt.sh
PROMPT_COMMAND='__posh_git_ps1 "%B%F{green}%n%f%bの%B%F{cyan}%M🐾%f%b" "%B%F{yellow}%~
%f%b%B%F{yellow}Ϣ  %b%f";'$PROMPT_COMMAND
precmd() { eval "$PROMPT_COMMAND" }

#finsh greeter
echo -e "${CYAN}おかえり"
echo -e "何をしたいですか${COLOREND}"
