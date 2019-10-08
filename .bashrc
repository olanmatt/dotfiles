# set color scheme
BASE16_SHELL="$HOME/.bash/colors/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"
if type base16_tomorrow-night > /dev/null; then
   base16_tomorrow-night
fi

# set PS1 with git if possible
if type __git_ps1 &> /dev/null ; then
  export PS1='\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]$(__git_ps1) \[\033[0m\]\n\$ \[$(tput sgr0)\]'
else
  export PS1='\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[0m\]\n\$ \[$(tput sgr0)\]'
fi

# start ssh-agent
if ! ssh-add -L >& /dev/null; then
  eval `ssh-agent -s` >& /dev/null
  ssh-add >& /dev/null
fi

# add ssh identity
if [[ -r ~/.ssh/id_rsa ]]; then
   ssh-add ~/.ssh/id_rsa > /dev/null 2>&1
fi

if which pyenv > /dev/null; then
   eval "$(pyenv init -)"
fi

# setup virtualenv for python
if [ -r /usr/local/bin/virtualenvwrapper.sh ]; then
   source /usr/local/bin/virtualenvwrapper.sh
fi

#############
# Variables #
#############
# make vim default
export VISUAL=vim
export EDITOR="$VISUAL"
export CLICOLOR=1
export PATH=~/.bin:${PATH}

###########
# Aliases #
###########
# enable colors
ls --color=auto &> /dev/null && alias ls='ls --color=auto' ||
alias grep="grep --color=always"
alias tmux="TERM=xterm-256color tmux"
alias pipupdate="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

alias pls="ps aux | grep -i"
alias ports="sudo netstat -tulpn"
alias port="sudo netstat -tulpn | grep -i"

#tl: list sessions
alias tl='tmux ls'
#tn <name>: create a session named <name>
alias tn='tmux new -s'
#ta <name>: attach to a session named <name>
alias ta='tmux attach -d -t'

alias kube='kubectl'

alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

#############
# Functions #
#############
function scope {
   grep -RIn "$*" `find . -type f -name "*.H" -o -name "*.C"`
}

function title {
  echo -ne "\033]0;"$*"\007"
}

function latest {
   ls -t $* | head -1
}

function hex {
   xxd $* | less
}

if [ -f ~/.bashrc.local ]; then . ~/.bashrc.local; fi
