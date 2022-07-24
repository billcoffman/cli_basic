#!/bin/bash

#echo Hello Bash_Aliases\!
source ~/.bash_aliases_jobs
source ~/.bash_aliases_tmux
source ~/.bash_aliases_ssh
source ~/.bash_aliases_git
source ~/.bash_aliases_python

# Misc
alias l="ls -FG"
alias ll="ls -lAGghtr"
alias lla="ls -lAGtr"
alias lld="ls -lAGtrd"
alias lll="ls -lGghtr"
alias lld="ls -lAGghtr"
alias s='source ~/.bashrc'
alias a='alias | grep '
alias via='vi ~/.bash_aliases'

# Git aliases.
alias gpo='git rev-parse --abbrev-ref HEAD | xargs git push origin'
alias gpso='git rev-parse --abbrev-ref HEAD | xargs git push origin'
alias gplo='git rev-parse --abbrev-ref HEAD | xargs git pull origin'
alias gb='git branch'
alias gcb="perl $HOME/bin/git_change_branch.pl"
alias gmd="perl $HOME/bin/git_merge_down.pl"
alias gstat='git status|less'

export SV_HOME=${HOME}/dev/virtualenvs
# Selection (formerly switch) aliases.
function sd () { switch_dir.pl    $@ && dir=$(cat ${HOME}/.sd/curr) && cd "$dir";}
function sb () { switch_branch.pl $@ && git checkout $(cat ${HOME}/.sb/curr);}
function sv () { switch_venv.pl   $@ && source $(cat ${HOME}/.sv/curr)/bin/activate;}
# python3 -m venv .venv && source .venv/bin/activate

export WORKON=${SV_HOME}
export WORKON_HOME=${SV_HOME}
alias python=python3
alias py=python3
alias py3=python3
alias py2=python2


export WORKON=${HOME}/dev/virtualenvs
export WORKON_HOME=${HOME}/dev/virtualenvs
alias python=python3
alias py=python3
alias py3=python3
alias py2=/usr/local/Cellar/python@2/2.7.16/bin/python2
alias python2=/usr/local/Cellar/python@2/2.7.16/bin/python2
export WORKON_HOME=${HOME}/dev/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
