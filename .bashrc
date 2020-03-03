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
user_host='\[\033[01;32m\]\u@\h'
colon='\[\033[00m\]:'
path='\[\033[01;34m\]\w'
time=' \[\033[01;30m\][$(date +%H:%M:%S)]'
prompt='\[\033[00m\]\n\$ '
PS1="${newline}${user_host}${colon}${path}${time}${prompt}"

# If git installed, add git branch and status
which git >/dev/null 2>&1
if [[ $? = 0 ]]
then
	git_branch='\[\033[33m\]$(git branch --show-current 2>/dev/null | sed -e"s/\(.\\+\)/ (\1)/")'
	git_status='$(git status --untracked-files=no dgsgdssdgdgsgd 2>/dev/null | grep -E "(Your branch is ahead of)|(Your branch is behind)|(different commits each)" | sed -e "s/Your branch is ahead of.\\+by \([0-9]\\+\) commit.\\+/ (\1↑)/" | sed -e "s/Your branch is behind.\\+by \([0-9]\\+\) commit.\\+/ (\1↓)/" | sed -e "s/and have \([0-9]\\+\) and \([0-9]\\+\) different commits each, respectively.\\+/ \[\033[01;31m\](\1↑ \2↓)/")'
	PS1="${newline}${user_host}${colon}${path}${git_branch}${git_status}${time}${prompt}"
fi

source ~/env.sh
source ~/aliases.sh

# Helper functions
reniceall() {
	for p in `pgrep -f "$1"` ; do sudo renice -20 $p ; done
}

# Best viewed as a side pane with lines=37
alias smalltop="watch -n5 -t \"top -b -n1 -o '%MEM' -w512 | tail -n+8 | head -n \\\$((\\\$LINES-1)) | awk 'BEGIN{printf \\\"%6s %6s %6s %-15s\n\\\", \\\"PID\\\", \\\"CPU%\\\", \\\"MEM%\\\", \\\"COMMAND\\\"} {printf \\\"%6s %5s%% %5s%% %-15s\n\\\", \\\$1, \\\$9, \\\$10, \\\$12}'\""
