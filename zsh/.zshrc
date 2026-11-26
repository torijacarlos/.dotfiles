# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

## remove default alias

unalias -m "gf"
unset HISTFILE

## expand PATH

export PATH="$HOME/.local/.atelier:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/links:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

### odin
export PATH="$HOME/kura/code/odin:$PATH"
export PATH="$HOME/kura/code/ols:$PATH"

## export for fcitx

export QT_IM_MODULE='fcitx5'
export SDL_IM_MODULE='fcitx5'
export XMODIFIERS='@im=fcitx5'

## git aliases

alias gca="git commit --amend --no-edit"
alias gbv="git branch -v"
alias gfi="gaa && gca"

## vim aliases

alias vim="nvim"
alias v="nvim"

## simplified commands

alias rg="rg -i"
alias tortoise="rsync -a --delete --exclude lost+found /home/torija/kura/ /mnt/tortoise/kura/"

## tmux aliases

alias tw="tca-work"
alias ts="tmux-session"
alias ta="tmux attach"
alias tks="tmux kill-server"

## development

alias python="python3"
alias pip="pip3"

export EDITOR="nvim"
export VISUAL="nvim"
export LLVM_CONFIG="/usr/bin/llvm-config"

## personal tools 

alias todo="rg todo --no-heading --sort path --trim -g '!_*'"
alias note="rg note --no-heading --sort path --trim"
alias mpdf="pandoc --pdf-engine=pdfroff"

## stuff
autoload -U compinit
compinit -d ~/.cache/zsh/zcompdump

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

if hash aactivator 2>/dev/null; then
    eval "$(aactivator init)"
fi

if [[ -n $SSH_CONNECTION ]]; then
    PROMPT="%F{red}[%m]%f $PROMPT"
fi

