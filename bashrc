# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

export CVS_RSH="ssh"
export CVSEDIT="vim"
export UXRES="800x600@16"
export L4BIN="/home/doebel/src/tudos/trunk/build_l4re_x86/bin/x86_686/l4f"
export MYL4DIR="/home/doebel/src/tudos/trunk/l4"
export L4REDIR="/home/doebel/src/tudos/trunk/l4re/l4"
export FIASCOUX="/home/doebel/src/l4-svn/kernel/fiasco/build_ux/fiasco"
export QEMU_SVN="/home/doebel/src/qemu"
export MINICOM="-c on"

export GREP_COLOR='1;34'
export GREP_OPTIONS='--color=auto'
export ACK_OPTIONS='-i'
export ACK_COLOR_MATCH='bold blue'
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=" -R "

export LINUX='/home/doebel/src/linux/linux-2.6.29'

export PATH="/home/doebel/local/bin:$PATH:/opt/openoffice.org3/program:/usr/local/gcc/4.2-arm-softfloat/bin/"


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[32;1m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
    ;;
xterm)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[32;1m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

alias unsetenv=unset
function setenv () {
  export $1="$2"
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

#
# Csh compatability:
#
alias unsetenv=unset
function setenv () {
  export $1="$2"
}

# Function which adds an alias to the current shell and to
# the ~/.bash_aliases file.
add-alias ()
{
   local name=$1 value="$2"
   echo alias $name=\'$value\' >>~/.bash_aliases
   eval alias $name=\'$value\'
   alias $name
}

# check resolv.conf for inf.tu-dresden.de and add it to the search path, so that
# resolutions such as os, erwin, etc. work
fix_resolv()
{
	if ! cat /etc/resolv.conf | grep inf >/dev/null; then
		set -x
		sudo sh -c "echo search inf.tu-dresden.de >> /etc/resolv.conf"
		set +x
	fi
}

# "repeat" command.  Like:
#
#	repeat 10 echo foo
repeat ()
{ 
    local count="$1" i;
    shift;
    for i in $(seq 1 "$count");
    do
        eval "$@";
    done
}

# Subfunction needed by `repeat'.
seq ()
{ 
    local lower upper output;
    lower=$1 upper=$2;

    if [ $lower -ge $upper ]; then return; fi
    while [ $lower -le $upper ];
    do
	echo -n "$lower "
        lower=$(($lower + 1))
    done
    echo "$lower"
}

L4ENV_BUILDDIR="/home/doebel/src/tudos/trunk/build_x86"
L4REX86_BUILDDIR="/home/doebel/src/tudos/trunk/build_l4re_x86"
L4REAMD64_BUILDDIR="/home/doebel/src/tudos/trunk/build_l4re_amd64"
L4REARM_BUILDDIR="/home/doebel/src/tudos/trunk/build_l4re_arm"
FIASCO_BUILDDIR="/home/doebel/src/tudos/trunk/kernel/fiasco/build"
FIASCO_UX_BUILDDIR="/home/doebel/src/tudos/trunk/kernel/fiasco/build_ux"
FIASCO_DEV_X86_BUILDDIR="/home/doebel/src/tudos/trunk/kernel/fiascodev/build"
FIASCO_DEV_AMD64_BUILDDIR="/home/doebel/src/tudos/trunk/kernel/fiascodev/build_amd64"
FIASCO_DEV_ARM_BUILDDIR="/home/doebel/src/tudos/trunk/kernel/fiascodev/build_arm"
OK_ICON=/usr/share/icons/oxygen/48x48/actions/dialog-ok.png
FAIL_ICON=/usr/share/icons/oxygen/48x48/status/dialog-error.png

make_fn()
{
	arch=$1;
	shift;
	
	dir=`pwd`;
	echo $dir;

	if [[ $dir =~ "l4re" ]]; then
		if [ $arch == "x86" ]; then
			echo "L4RE/x86";
			BUILDDIR=$L4REX86_BUILDDIR;
		elif [ $arch == "arm" ]; then
			echo "L4RE/ARM";
			BUILDDIR=$L4REARM_BUILDDIR;
		elif [ $arch == "amd64" ]; then
			echo "L4RE/AMD64";
			BUILDDIR=$L4REAMD64_BUILDDIR;
		fi
		nice make PL=2 O=$BUILDDIR --no-print-directory $@
	elif [[ $dir =~ "l4$" ]]; then
		echo "L4Env/x86";
		BUILDDIR=$L4ENV_BUILDDIR;
		nice make PL=2 O=$BUILDDIR --no-print-directory $@
	elif [[ $dir =~ "kernel/fiascodev" ]]; then
		echo "Fiasco.DEV build";
		if [ $arch == "x86" ]; then
			echo "Fiasco.DEV/x86";
			BUILDDIR=$FIASCO_DEV_X86_BUILDDIR;
		elif [ $arch == "amd64" ]; then
			echo "Fiasco.DEV/AMD64";
			BUILDDIR=$FIASCO_DEV_AMD64_BUILDDIR;
		elif [ $arch == "arm" ]; then
			echo "Fiasco.DEV/ARM";
			BUILDDIR=$FIASCO_DEV_ARM_BUILDDIR;
		fi

		nice make O=$BUILDDIR --no-print-directory $@
	elif [[ $dir =~ "kernel/fiasco" ]]; then
		if [ $arch == "ux" ]; then
			echo "Fiasco/UX x86"
			BUILDDIR=$FIASCO_UX_BUILDDIR;
		else
			echo "Fiasco/x86"
			BUILDDIR=$FIASCO_BUILDDIR;
		fi

		make O=$BUILDDIR --no-print-directory $@
	else
		echo "normal x86 build";
		make $@
	fi

	if [ $? == 0 ]; then
		notify-send --urgency=normal --icon=$OK_ICON "Compile" "Done"
	else
		notify-send --urgency=critical --icon=$FAIL_ICON "Compile" "Error"
	fi
}


export GOROOT=/home/doebel/src/go
export GOOS=linux
export GOARCH=386
export GOBIN=/home/doebel/local/bin

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

run_ctags ()
{
	ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
}
