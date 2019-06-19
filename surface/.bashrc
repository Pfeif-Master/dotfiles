#
# ~/.bashrc
#

export YELLOW="\[\033[1;33m\]"
export GREEN="\[\033[1;32m\]"
export CYAN="\[\033[1;36m\]"
export BLUE="\[\033[1;34m\]"
export RED="\[\033[1;31m\]"
export COLOREND="\[\033[m\]"

export E_YELLOW="\033[1;33m"
export E_GREEN="\033[1;32m"
export E_CYAN="\033[1;36m"
export E_BLUE="\033[1;34m"
export E_RED="\033[1;31m"
export E_COLOREND="\033[m"

#start greeter
~/art1.sh
# echo -ne "${E_CYAN}"
# cat ~/dotfiles/surface/art1
# echo -e "${E_GREEN}システムスタート${E_COLOREND}"
# echo -e "\t\t\t\t${E_CYAN}何お${E_GREEN}シ"
# echo -e "\t\t\t\t${E_CYAN}をか${E_GREEN}ス"
# echo -e "\t\t\t\t${E_CYAN}しえ${E_GREEN}テ"
# echo -e "\t\t\t\t${E_CYAN}たり${E_GREEN}ム"
# echo -e "\t\t\t\t${E_CYAN}い  ${E_GREEN}ス"
# echo -e "\t\t\t\t${E_CYAN}で  ${E_GREEN}タ"
# echo -e "\t\t\t\t${E_CYAN}す  ${E_GREEN}ー"
# echo -e "\t\t\t\t${E_CYAN}か  ${E_GREEN}ト"
# echo -ne "${E_COLOREND}"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#prompt
source ~/posh-git-sh/git-prompt.sh
PROMPT_COMMAND='__posh_git_ps1 "${GREEN}\u${COLOREND}の${CYAN}\h🐾${COLOREND}" "${YELLOW}\w\n\[\033[m\]${YELLOW}Ϣ  \[\033[m\]";'$PROMPT_COMMAND

# PROMPT_COMMAND='__posh_git_ps1 "\033[1;36m\u⚔ \033[1;32m@\h⛩ \033[m" " \033[1;33m\w \nϢ  \[\033[m\]";'$PROMPT_COMMAND

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ginit='git init; git ci --allow-empty -m "INIT COMIT"'
alias py='python3'

alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias ......="cd ../../../../../"
alias .......="cd ../../../../../../"

alias g="git"
alias meow="source ~/.bashrc"
# alias python="python3"
# alias pip="pip3"

alias edit_bash="vim ~/.bashrc"
alias edit_vim="vim ~/_vimrc"
alias edit_git="vim ~/.gitconfig"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function colors {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

function mkdird {
	mkdir $1
	cd $1
}

##finsh greeter
#echo -e "${E_CYAN}おかえり"
#echo -e "何をしたいですか${E_COLOREND}"
