#
# ~/.bashrc
#
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# --- Color definitions (PS1-safe, wrapped in \[...\]) ---
export YELLOW="\[\033[1;33m\]"
export GREEN="\[\033[1;32m\]"
export CYAN="\[\033[1;36m\]"
export BLUE="\[\033[1;34m\]"
export RED="\[\033[1;31m\]"
export COLOREND="\[\033[m\]"

# --- Color definitions (for echo -e, no \[...\] wrappers) ---
export E_YELLOW="\033[1;33m"
export E_GREEN="\033[1;32m"
export E_CYAN="\033[1;36m"
export E_BLUE="\033[1;34m"
export E_RED="\033[1;31m"
export E_COLOREND="\033[m"

# --- Greeter ---
source ~/dotfiles/surface/art1
# --- End Greeter ---

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Check window size after each command
shopt -s checkwinsize

# Append history instead of overwriting
shopt -s histappend

# Make less friendlier for non-text input
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# --- Prompt ---
# posh-git removed — swap in Starship
PS1="${GREEN}\u${COLOREND}の${CYAN}\h🐾${COLOREND} ${YELLOW}\w${COLOREND}\n${YELLOW}Ϣ  ${COLOREND}"
eval "$(starship init bash)"

# --- Aliases ---
alias cp="cp -i"                          # confirm before overwriting
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias ......="cd ../../../../../"
alias .......="cd ../../../../../../"

alias g="git"
alias ginit='git init; git commit --allow-empty -m "INIT COMMIT"'
alias py='python3'

alias meow="source ~/.bashrc"
alias edit_bash="vim ~/.bashrc"
alias edit_vim="vim ~/_vimrc"
alias edit_git="vim ~/.gitconfig"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# --- Programmable completion ---
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# --- Archive extractor: ex <file> ---
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

# --- Color chart utility ---
function colors {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	for fgc in {30..37}; do
		for bgc in {40..47}; do
			fgc=${fgc#37}
			bgc=${bgc#40}
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

# --- mkdir + cd ---
function mkdird {
	mkdir $1
	cd $1
}
