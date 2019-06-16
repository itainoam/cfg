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


# make aliases work with sudo
alias sudo='sudo '

alias g='git'
alias ui-start='API_PROXY=ui-proxy npm start --prefix /Users/itai/dev/mui/js/client'
alias codereview='/Users/itai/dev/codereview/codereview.sh'
alias gc='git commit -v'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status -s'
alias config='/usr/local/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cj="jira view $(git branch | sed -n '/\* /s///p' | grep -oiE 'ui-[0-9]{4}')"
alias laptop-mount="sudo sshfs -o allow_other,defer_permissions,IdentityFile=/Users/itai/.ssh/id_rsa itai@10.0.17.71:/home/itai/dev /Users/itai/laptop"
alias laptop-ssh="ssh itai@10.0.17.71"
alias ui-proxy="python /Users/itai/dev/mui/tools/ui-proxy"
alias sharbot='slack-cli -d sharbot "allocate" && sleep 5 && slack-cli -d sharbot "super extend" && slack-cli -l 3 -s sharbot | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | cut -f 1 | xargs sudo python /Users/itai/dev/mui/tools/ui-proxy'
alias mui-sync="while sleep 2; do ls ~/dev/mui/js/client/dist | entr -d npm run deploy ui-proxy; done"
alias magit="emacs --no-window-system --eval '(progn (magit-status) (delete-other-windows))'"

sharbot1() {
  slack-cli -d sharbot "allocate";
  sleep 5 && slack-cli -d sharbot "super extend";
  slack-cli -l 3 -s sharbot | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | cut -f 1 | xargs sudo python /Users/itai/dev/mui/tools/ui-proxy
}

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

printing_test () {
  # shows how printing to prompt can be done. can be used improve jiras by pasting branch name into terminal.
  JIRA=$(git branch | sed -n '/\* /s///p' | grep -oiE 'ui-[0-9]{4}'); print -z $JIRA;
  print -z $JIRA;
  }

jiras() {
    jira list --query "resolution = unresolved and status = open and assignee=currentuser() ORDER BY created" |\
        fzf  --height 90% --reverse --bind 'ctrl-x:execute(echo {}| cut -d : -f 1 | xargs echo -n | pbcopy)+abort'  \
        --header 'Press CTRL-X to copy, ENTER to browse' \
        --preview-window down:25 --preview="echo {}| cut -d : -f 1 |xargs -I % sh -c 'jira view %'" |\
        awk -F ":" '{print $1}' | xargs -I % sh -c 'jira browse %' 
}

prs() {
    hub pr list -f "%sC%>(8)%I%Creset %t% l%n" | fzf --height 40% --reverse | awk '{print $1}' | xargs -I % sh -c 'hub pr checkout %'
}

g-fixup() {
oldcommit=$(git --no-pager log --pretty=format:'%h %<(20)%an %<(15)%cr %s' |\
  fzf  --height 90% --reverse\
        --bind "ctrl-n:preview-page-down,ctrl-p:preview-page-up,q:abort"\
        --header 'Select which commit to add changes to. ctrl-n, ctrl-p to scroll diff. ' \
        --expect=enter \
        --preview-window down:25 --preview="git diff --color --staged | diff-so-fancy" |\
        awk '{print $1}') && [ ! -z "$oldcommit" ] && git commit --fixup=$oldcommit && git rebase --interactive --autosquash $oldcommit~
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

