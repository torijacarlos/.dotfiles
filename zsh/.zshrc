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
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"


## git aliases

alias gca="git commit --amend --no-edit"
alias gbv="git branch -v"
alias gfi="gaa && gca"

## vim aliases

alias vim="nvim"
alias v="nvim"

## rclone alias

alias rpull="rclone copy drive:/ ~/drive"
alias rpush="rclone sync --drive-import-formats=xlsx ~/drive drive:/"

## tmux aliases

alias tw="tmux-session"
alias twl="tmux-session -l"

## development

alias python="python3"
alias pip="pip3"

## handmade personal tools 

alias sbg="swaybg-randomizer -r"

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
