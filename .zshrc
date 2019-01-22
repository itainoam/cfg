#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
#if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
#fi

# Antigen plugins
source ~/antigen.zsh
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git

# Syntax highlighting bundle.
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search

# Tell Antigen that you're done.
antigen apply

# Bind up/down for history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Customize to your needs...
export PATH=$PATH:$HOME/bin

# Load history (and set to unlimited length)
HISTFILE=~/.zsh_history
HISTSIZE=10000
HISTFILESIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY

# Adds Powerline
function powerline_precmd() {
    PS1="$(~/bin/powerline-go -modules venv,ssh,cwd,perms,git,jobs,exit,root -error $? -shell zsh)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

# adds autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

export NVM_DIR="/Users/itai/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# FZF config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
