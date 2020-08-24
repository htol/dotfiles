# Path to your oh-my-zsh installation.
#export ZSH="$HOME/.local/oh-my-zsh"

#ZSH_THEME="gentoo"

#plugins=(
#  git colorize pip python tmux python
#)

ZSH_COLORIZE_STYLE="colorful"

#source $ZSH/oh-my-zsh.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

HISTFILE=~/.config/zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt appendhistory

load-ansible(){
	# TODO: ansible path as env variable?
	if [ -f ${HOME}/.local/ansible/hacking/env-setup ]; then
		source ~/.local/ansible/hacking/env-setup
		echo "Ansible environment loaded"
	fi
}

cd
