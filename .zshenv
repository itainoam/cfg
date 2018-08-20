#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi

alias g='git'
alias ui-start='API_PROXY=ui-proxy npm start --prefix /Users/itai/dev/mui/js/client'
alias codereview='/Users/itai/dev/codereview/codereview.sh'
alias gc='git commit -v'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status -s'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cj="jira view $(git branch | sed -n '/\* /s///p' | grep -oiE 'ui-[0-9]{4}')"

codi() {
    local syntax="${1:-javascript}"
    vim -c \
        "let g:startify_disable_at_vimenter = 1 |\
        set bt=nofile ls=0 noru nonu nornu |\
        hi ColorColumn ctermbg=NONE |\
        hi VertSplit ctermbg=NONE |\
        hi NonText ctermfg=0 |\
        Codi $syntax" "$@"
    }

jiras() {
    jira list --query "resolution = unresolved and status = open and assignee=currentuser() ORDER BY created" |\
        fzf  --height 90% --reverse --bind 'ctrl-x:execute(echo {}| cut -d : -f 1 | pbcopy)+abort'  \
            --header 'Press CTRL-X to copy, ENTER to browse' \
        --preview-window down:25 --preview="echo {}| cut -d : -f 1 |xargs -I % sh -c 'jira view %'" |\
        awk -F ":" '{print $1}' | xargs -I % sh -c 'jira browse %' 
}

prs() {
    hub pr list -f "%sC%>(8)%I%Creset %t% l%n" | fzf --height 40% --reverse | awk '{print $1}' | xargs -I % sh -c 'hub pr checkout %'
}


g-start() {
git fetch && git checkout master && git rebase --autostash && git checkout -b "itai/$1" master; 
}

g-finish() {
JIRA=$(git branch | sed -n '/\* /s///p' | grep -oiE 'ui-[0-9]{4}')
jira transition --noedit 'Start Progress' $JIRA || true;
jira transition --noedit 'Ready for review' $JIRA || true;
    hub pull-request --push --browse --no-edit
}
