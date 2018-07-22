# Add `~/bin` to the `$PATH`
export PATH="/usr/local/git/bin:$HOME/bin:$PATH";

# sets up config repo https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# .bash_profile is always read, while .bashrc not always. Read .bashrc if exists.
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

# powerline 
function _update_ps1() {
    PS1="$(~/bin/powerline-go -modules venv,ssh,cwd,perms,git,jobs,exit,root -error $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export PS1="\[\033[0m\]\w\$ "
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Setting PATH for Python 3.6
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# better autocomplete
bind "set completion-ignore-case on"
# set menu-complete-display-prefix on
# bind "set show-all-if-ambiguous on"
# TAB:menu-complete

# history with date
export HISTTIMEFORMAT="%d/%m/%y %T "

# bash completion
if [ -f $HOME/.bin/bash_completion ]; then
   . $HOME/.bin/bash_completion
fi
# load completions
for bcfile in ~/.bash_completion.d/* ; do
     [ -f "$bcfile" ] && . $bcfile
done

alias ll='ls -la'
