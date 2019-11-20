#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll="ls -l"
alias la="ls -la"

PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;30m\] [$(date +%H:%M:%S)]\[\033[00m\]\n\$ '
which git >/dev/null 2>&1
if [[ $? = 0 ]]
then
	PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]$(git branch --show-current 2>/dev/null | sed -e"s/\(.\\+\)/ (\1)/")$(git status | grep "Your branch is ahead of" | sed -e "s/.\\+by \([0-9]\\+\) commit.\\+/ (\1)/")\[\033[01;30m\] [$(date +%H:%M:%S)]\[\033[00m\]\n\$ '
fi

export GDK_BACKEND=x11
source ~/env.sh
source ~/aliases.sh
