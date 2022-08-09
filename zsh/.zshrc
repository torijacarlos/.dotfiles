# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

## expand PATH

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

## git aliases

alias gca="git commit --amend --no-edit"
alias gbv="git branch -v"

## vim aliases

alias vim="nvim"
alias v="nvim"

## tmux aliases

alias tw="tmux-session"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Functions

wthr() {
    if [ -n "$1" ]
    then
        curl wttr.in/"$1"
    else
        curl wttr.in/
    fi
}

eval $(thefuck --alias)
