# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

## expand PATH

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/links:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"


## git aliases

alias gca="git commit --amend --no-edit"
alias gbv="git branch -v"
alias gfi="gaa && gca"

## vim aliases

alias vim="nvim"
alias v="nvim"

## rclone alias

alias rpull="rclone copy drive:/ ~/drive"
alias rpush="rclone sync ~/drive drive:/"

## tmux aliases

alias tw="tmux-session"
alias twl="tmux-session -l"

## random stuff alias

alias nitro="nitrogen --random --set-zoom"


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
