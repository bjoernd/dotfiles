# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

source ~/.bash.local

for var in L4RE_BASE L4RE_PKG FIASCO_DEV_BASE FIASCO_SRC; do
	if [ -z "$(echo $(env | grep $var))" ]; then
		echo "$var NOT SET!";
		return
	fi
done

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
export MINICOM="-c on"

export GREP_COLOR='1;34'
export GREP_OPTIONS='--color=auto'
export ACK_OPTIONS='-i'
export ACK_COLOR_MATCH='bold blue'
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=" -R "

PATH="/home/doebel/local/bin:$PATH"
export PATH


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[33m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
    ;;
xterm)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[33m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
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

toupper()
{
	local char="$*"
	out=$(echo $char | tr [:lower:] [:upper:])
	local retval=$?
	echo "$out"
	unset out
	return $retval
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

OK_ICON=/usr/share/icons/oxygen/48x48/actions/dialog-ok.png
FAIL_ICON=/usr/share/icons/oxygen/48x48/status/dialog-error.png

make_fn()
{
	arch=$1;
	shift;
	
	dir=`pwd`;
	echo $dir;

	if [[ $dir =~ $L4RE_PKG ]]; then
		if [ $arch == "x86" ]; then
			echo "L4RE/x86";
			BUILDDIR=$L4REX86_BUILDDIR;
		elif [ $arch == "arm" ]; then
			echo "L4RE/ARM";
			BUILDDIR=$L4REARM_BUILDDIR;
		elif [ $arch == "amd64" ]; then
			echo "L4RE/AMD64";
			BUILDDIR=$L4REAMD64_BUILDDIR;
		elif [ $arch == "sparc" ]; then
			echo "L4Re/Sparc";
			BUILDDIR=$L4RESPARC_BUILDDIR;
		fi
		nice make O=$BUILDDIR --no-print-directory $@

	elif [[ $dir =~ $FIASCO_SRC ]]; then
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
		elif [ $arch == "sparc" ]; then
			echo "Fiasco.DEV/Sparc";
			BUILDDIR=$FIASCO_DEV_SPARC_BUILDDIR;
		fi

		nice make O=$BUILDDIR --no-print-directory $@

	else
		echo "normal x86 build";
		make $@
	fi

#	if [ $? == 0 ]; then
#		notify-send --urgency=normal --icon=$OK_ICON "Compile" "Done"
#	else
#		notify-send --urgency=critical --icon=$FAIL_ICON "Compile" "Error"
#	fi
}


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

erwin_license_tunnel ()
{
	ssh -N \
		-L licerwin:8224:licerwin:8224 \
		-L licsilo:8225:licsilo:8225 \
		-L licblei:8226:licblei:8226 \
		-L licerwin:42175:licerwin:42175 \
		erwin.inf.tu-dresden.de
}

d ()
{
	project=$(basename $(pwd))
	if [[ -z $2 ]]; then
		ditz $1
	else
		ditz $1 $project-$2
	fi
}
