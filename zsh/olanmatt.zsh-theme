# olanmatt ZSH Theme

precmd() {
PROMPT='$(_user_host)${_current_dir}$(git_prompt_info)$(_ruby_version)$(_virtualenv_prompt_info)
$ '
}

RPROMPT='%{$(echotc UP 1)%}${_return_status}%{$(echotc DO 1)%}'

function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

local _return_status="%(?.%{$fg[white]%}[%?]%{$reset_color%}.%{$fg[red]%}[%?]%{$reset_color%})"
local _current_dir="%{$fg[blue]%}%3~%{$reset_color%}"
local _hist_no="%{$fg[grey]%}%h%{$reset_color%}"

function _user_host() {
    if [[ -n $SSH_CONNECTION ]]; then
        me="%n@%m"
    elif [[ $LOGNAME != $USER ]]; then
        me="%n"
    fi
    if [[ -n $me ]]; then
        echo "%{$fg[cyan]%}$me%{$reset_color%}:"
    fi
}

function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " $(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function _ruby_version() {
    if {echo $fpath | grep -q "plugins/rvm"}; then
        echo " %{$fg[magenta]%}$(rvm_prompt_info)%{$reset_color%}"
    fi
}

function _virtualenv_prompt_info() {
    if [ -n "$VIRTUAL_ENV" ]; then
        if [ -f "$VIRTUAL_ENV/__name__" ]; then
            local name=`cat $VIRTUAL_ENV/__name__`
        elif [ `basename $VIRTUAL_ENV` = "__" ]; then
            local name=$(basename $(dirname $VIRTUAL_ENV))
        else
            local name=$(basename $VIRTUAL_ENV)
        fi
        echo " %{$fg[yellow]%}$name%{$reset_color%}"
    fi
}

# Change caret colour for root
if [[ $USER == "root" ]]; then
    CARETCOLOR="red"
else
    CARETCOLOR="white"
fi

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLOR='1;33'
