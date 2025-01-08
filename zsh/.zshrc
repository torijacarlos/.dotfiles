# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

## expand PATH

export PATH="$HOME/.local/.atelier:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/rust/bin:$PATH"
export PATH="$HOME/.local/links:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"


## git aliases

alias gca="git commit --amend --no-edit"
alias gbv="git branch -v"
alias gfi="gaa && gca"

## vim aliases

alias vim="nvim"
alias v="nvim"

## simplified commands

alias rpull="rclone copy drive:/sync/ ~/drive"
alias rpush="rclone sync ~/drive drive:/sync"
alias rg="rg -i"

## tmux aliases

alias tw="tmux-session"
alias twl="tmux-session -l"

## development

alias python="python3"
alias pip="pip3"

## personal tools 

alias es="elixir-schedule"
alias ef="elixir-finance"
alias todo="rg todo --no-heading --sort path --trim"
alias note="rg note --no-heading --sort path --trim"
alias mpdf="pandoc --pdf-engine=pdfroff"
alias tcb="torijacarlos_bluetooth_toggle"
alias tcd="scythe swaybg -d ~/drive/digitalart/illustration"
alias tbg="swaybg -i ~/drive/drawing/bg.png --mode fill"

## stuff

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "/opt/homebrew/bin" ] && export PATH="/opt/homebrew/bin:$PATH"

if hash aactivator 2>/dev/null; then
    eval "$(aactivator init)"
fi

export LC_CTYPE="UTF-8"
