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
. /home/doebel/src/powerline/powerline/bindings/zsh/powerline.zsh

export CVS_RSH="ssh"
export CVSEDIT="vim"
export L4BIN="/home/doebel/src/tudos/l4/build/"
export L4REDIR="/home/doebel/src/tudos/l4"
export MINICOM="-c on"

export GREP_COLOR='1;34'
export GREP_OPTIONS='--color=auto'
export ACK_OPTIONS='-i'
export ACK_COLOR_MATCH='bold blue'
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=" -R "

export LINUX='/home/doebel/src/linux/linux-2.6.29'


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
#repeat ()
#{ 
#    local count="$1" i;
#    shift;
#    for i in $(seq 1 "$count");
#    do
#        eval "$@";
#    done
#}

# Subfunction needed by `repeat'.
seq ()
{ 
    local lower upper output;
    lower=$1 upper=$2;

    if [ $lower -gt $upper ]; then return; fi
    while [ $lower -le $upper ];
    do
	echo -n "$lower "
        lower=$(($lower + 1))
    done
    echo
}

L4REX86_BUILDDIR="/home/doebel/src/tudos/l4/build"
L4REAMD64_BUILDDIR="/home/doebel/src/tudos/l4/build64"
L4REARM_BUILDDIR="/home/doebel/src/tudos/l4/buildarm"
L4RESPARC_BUILDDIR="/home/doebel/src/tudos/l4/build-sparc"
FIASCO_DEV_X86_BUILDDIR="/home/doebel/src/tudos/kernel/fiasco/build"
FIASCO_DEV_SPARC_BUILDDIR="/home/doebel/src/tudos/kernel/fiasco/build-sparc"
FIASCO_DEV_AMD64_BUILDDIR="/home/doebel/src/tudos/kernel/fiasco/build_amd64"
FIASCO_DEV_ARM_BUILDDIR="/home/doebel/src/tudos/kernel/fiasco/build_arm"

make_fn()
{
	arch=$1;
	shift;
	
	dir=`pwd`;
	echo $dir;

	if [[ $dir =~ "tudos/l4/pkg" ]]; then
		if [[ $arch == "x86" ]]; then
			echo "L4RE/x86";
			BUILDDIR=$L4REX86_BUILDDIR;
		elif [[ $arch == "arm" ]]; then
			echo "L4RE/ARM";
			BUILDDIR=$L4REARM_BUILDDIR;
		elif [[ $arch == "amd64" ]]; then
			echo "L4RE/AMD64";
			BUILDDIR=$L4REAMD64_BUILDDIR;
		elif [[ $arch == "sparc" ]]; then
			echo "L4Re/Sparc";
			BUILDDIR=$L4RESPARC_BUILDDIR;
		fi
		nice make O=$BUILDDIR --no-print-directory $@

	elif [[ $dir =~ "kpr/trunk" ]]; then
		echo "KPR"
		BUILDDIR=/home/doebel/src/tudos/kpr/trunk/obj/l4/x86
		nice make O=$BUILDDIR --no-print-directory $@

	elif [[ $dir =~ "kernel/fiasco" ]]; then
		echo "Fiasco.DEV build";
		if [[ $arch == "x86" ]]; then
			echo "Fiasco.DEV/x86";
			BUILDDIR=$FIASCO_DEV_X86_BUILDDIR;
		elif [[ $arch == "amd64" ]]; then
			echo "Fiasco.DEV/AMD64";
			BUILDDIR=$FIASCO_DEV_AMD64_BUILDDIR;
		elif [[ $arch == "arm" ]]; then
			echo "Fiasco.DEV/ARM";
			BUILDDIR=$FIASCO_DEV_ARM_BUILDDIR;
		elif [[ $arch == "sparc" ]]; then
			echo "Fiasco.DEV/Sparc";
			BUILDDIR=$FIASCO_DEV_SPARC_BUILDDIR;
		fi

		nice make O=$BUILDDIR --no-print-directory $@

	else
		echo "normal x86 build";
		make $@
	fi
}


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
		-L licerwin:47398:licerwin:47398 \
		erwin.inf.tu-dresden.de
}


unalias d

d ()
{
	project=$(basename $(pwd) | tr '[A-Z]' '[a-z]')
	if [[ -z $2 ]]; then
		ditz $1
	else
		ditz $1 $project-$2
	fi
}

suspm ()
{
	sudo sh -c "echo 'mem' > /sys/power/state" && \
	xscreensaver-command -lock
}
# ssh
alias loki="ssh bjoern@loki-new.rshc.de"
alias erwin="ssh -X doebel@erwin.inf.tu-dresden.de"
alias os="ssh doebel@os.inf.tu-dresden.de"

# commands
alias cgr="find . | grep -v .svn | grep -v .git | grep -v \~$ | grep \\.c$ | xargs grep -iIsHn"
alias cgrep="cgr"

# Linux: grep for definition of config option
alias lxdef="find . -name Kconfig | xargs grep "
# Linux kernel: grep Makefiles for occurence of a string (e.g., obj file)
alias lxobj="find . -name Makefile | xargs grep "

alias e="gvim --servername vimsrv --remote-silent"

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

function sodump()
{
	sparc-elf-objdump -lSCd $@ | less;
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

alias ag="ack-grep"
alias eu="erwin_update"
alias gr="find . | grep -v .svn | grep -v .git | grep -v \~$ | xargs grep -Iisn"
alias hgr="find . | grep -v .svn | grep -v .git | grep -v \~$ | grep \\.h$ | xargs grep -iIsHn"
alias hgrep="hgr"
alias ll="ls -lh"
alias ls="ls --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias m="make_fn x86"
alias mcm="make_fn x86 cleanall && make_fn x86"
alias marm="make_fn arm"
alias m64="make_fn amd64"
alias mcmarm="make_fn arm cleanall && make_fn arm"
alias msparc="make_fn sparc"
alias mcmsp="make_fn sparc cleanall && make_fn sparc"
alias mux="make_fn ux"
alias l="ls"
alias s="sudo"
alias t="task"
alias xdiff="gvimdiff"
alias mdiff="meld"
alias xl="xlock -mode blank"

# sudo
alias sagi="sudo apt-get install"
alias sagu="sudo apt-get update"
alias sagd="sudo apt-get dist-upgrade"
alias sagc="sudo apt-get clean"
alias sagr="sudo apt-get remove --purge --auto-remove"
alias acs="apt-cache search"
alias sins="sudo insmod"
alias srmod="sudo rmmod"
alias pwr_perf="sudo $HOME/local/bin/cpu perf"
alias pwr_save="sudo $HOME/local/bin/cpu power"

# cd shortcuts
alias cdbin="cd $L4BIN"
alias cdf="cd /home/doebel/src/fail/src/experiments/l4-sys"
alias cdi="cd /home/doebel/src/images/l4re/root/l4re"
alias cdlx="cd /home/doebel/src/tudos/trunk/l4linux-2.6/"
alias cdlx18="cd /home/doebel/src/linux/linux-2.6.18"
alias cdmag="cd $L4REDIR/tool/mag.py"
alias cdmk="cd $L4REDIR/mk"
alias cdn="cd /home/doebel/src/workspace/python/wx/nuggan"
alias cdo="cd $MYL4DIR/pkg/ore"
alias dde="cd $L4REDIR/pkg/dde/linux26/"
alias cdre="cd $L4REDIR/pkg"
alias cdp="cd $L4REDIR/pkg/plr/server/src"
alias cdv="cd $L4REDIR/pkg/valgrind"
alias fiascodev="cd /home/doebel/src/tudos/kernel/fiasco"
alias asteroid="cd /home/doebel/data/work/Projekte/ASTEROID"

alias vless='/usr/share/vim/vim72/macros/less.sh'
alias vl='vless'
alias la='ls -la'
alias tm='TERM=screen-256color tmux'

# Customize to your needs...
export PATH=/home/doebel/local/bin:/home/doebel/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/opt/sparc-elf-4.6.0/bin/:/opt/mkprom2:/opt/tsim/linux
