YELLOW="\[\033[1;33m\]"
GREEN="\[\033[1;32m\]"
CYAN="\[\033[1;36m\]"
BLUE="\[\033[1;34m\]"
RED="\[\033[1;31m\]"
COLOREND="\[\033[m\]"

E_YELLOW="\033[1;33m"
E_GREEN="\033[1;32m"
E_CYAN="\033[1;36m"
E_BLUE="\033[1;34m"
E_RED="\033[1;31m"
E_COLOREND="\033[m"

#start greeter
#set_color bryellow
echo -ne "${E_YELLOW}"
cat ~/dotfiles/surface/art1
echo -e "${E_GREEN}システムスタート${E_COLOREND}"


# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch
unsetopt appendhistory autocd beep notify
bindkey -v
# End of lines configured by zsh-newuser-install


#finsh greeter
echo -e "${E_CYAN}おかえり"
echo -e "何をしたいですか${E_COLOREND}"
