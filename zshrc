# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bjoernd"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn taskwarrior)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/doebel/local/bin:/home/doebel/.local/bin/:$PATH
. /home/doebel/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

export CVS_RSH="ssh"
export CVSEDIT="vim"
export EDITOR="vim"
export MINICOM="-c on"

export ACK_OPTIONS='-i'
export ACK_COLOR_MATCH='bold blue'
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=" -R "

export LINUX='/home/doebel/src/linux/linux-2.6.29'

run_ctags ()
{
	ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
}

alias erwin="ssh -X doebel@erwin.inf.tu-dresden.de"

# commands
alias cgr="find . | grep -v .svn | grep -v .git | grep -v \~$ | grep \\.c$ | xargs grep -iIsHn"
alias cgrep="cgr"

# Linux: grep for definition of config option
alias lxdef="find . -name Kconfig | xargs grep "
# Linux kernel: grep Makefiles for occurence of a string (e.g., obj file)
alias lxobj="find . -name Makefile | xargs grep "

alias e="vim"

# List the newest files in a certain directory
function newest()
{
	ls -lat $@ | head;
}

# objdump all sections, source annotations, disassembly
function odump()
{
	objdump -lSCd -Mintel $@ | less;
}

# run nm on a set of objects (ending with the 1st parameter) and
# grep the output for the 2nd parameter
function nmgrep ()
{
	for i in $( find \. -name \*$1 ); do
		if [[ ! -e $i ]]; then
			continue;
		fi
		nm -C $i | grep $2 > /tmp/foo.tmp;
		if [[ -s /tmp/foo.tmp ]]; then
			echo $i;
			cat /tmp/foo.tmp | grep $2
		fi
		rm /tmp/foo.tmp
	done
}

# find symbols definied/referenced in libs
function libgrep ()
{
	nmgrep .a $@
	nmgrep .so $@
}

# find symbols defined/referenced in object files
function ogrep ()
{
	nmgrep .o $@
}


function lxsys ()
{
	f32="/usr/include/x86_64-linux-gnu/asm/unistd_32.h"
	f64="/usr/include/x86_64-linux-gnu/asm/unistd_64.h"
	for f in $f32 $f64; do
		lxsysdef $f $1
	done
}

alias ag="ack-grep --ignore-file=is:tags"
alias gr="find . | grep -v .svn | grep -v .git | grep -v \~$ | xargs grep -Iisn"
alias hgr="find . | grep -v .svn | grep -v .git | grep -v \~$ | grep \\.h$ | xargs grep -iIsHn"
alias hgrep="hgr"
alias ll="ls -lh"
alias ls="ls --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias m="make"
alias l="ls"
alias s="sudo"

# sudo
alias sagi="sudo apt-get install"
alias sagu="sudo apt-get update"
alias sagd="sudo apt-get dist-upgrade"
alias sagc="sudo apt-get clean"
alias sagr="sudo apt-get remove --purge --auto-remove"
alias acs="apt-cache search"

alias vless='/usr/share/vim/vim72/macros/less.sh'
alias vl='vless'
alias la='ls -la'
alias tmux='TERM=screen-256color /usr/bin/tmux'

DISABLE_AUTO_TITLE=true
