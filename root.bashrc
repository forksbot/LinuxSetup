#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll="ls -l"
alias la="ls -la"

# Standard prompt
newline='\n'
user_host='\[\033[01;31m\]\u@\h'
colon='\[\033[00m\]:'
path='\[\033[01;34m\]\w'
time=' \[\033[01;30m\][$(date +%H:%M:%S)]'
prompt='\[\033[00m\]\n\$ '
PS1="${newline}${user_host}${colon}${path}${time}${prompt}"
