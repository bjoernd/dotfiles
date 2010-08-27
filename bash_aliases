# Aliases
# ssh
alias kiwi="ssh -X bd1@kiwi.inf.tu-dresden.de"
alias erwin="ssh -X doebel@erwin.inf.tu-dresden.de"
alias selen="ssh -X doebel@selen.inf.tu-dresden.de"
alias silo="ssh -X doebel@silo.inf.tu-dresden.de"
alias os="ssh doebel@os.inf.tu-dresden.de"

# commands
alias antlr="java org.antlr.Tool"
alias cgr="find . | grep -v .svn | grep \\.c$ | xargs grep -iIsHn"
alias cgrep="cgr"

# Linux: grep for definition of config option
alias lxdef="find . -name Kconfig | xargs grep "
# Linux kernel: grep Makefiles for occurence of a string (e.g., obj file)
alias lxobj="find . -name Makefile | xargs grep "

# Call vim
#
# XXX GCC error output oftentimes looks like <filename>:<line> and I want
# to call gvim without adapting it to vim's "jump to line" parameter
# which is "+<line>".
function e()
{
	VIMARGS="--servername vimsrv --remote-silent"

	gvim $VIMARGS $@;
}

# List the newest files in a certain directory
function newest()
{
	ls -lat $@ | head;
}

# objdump all sections, source annotations, disassembly
function odump()
{
	objdump -lSCd $@ | less;
}

# run nm on a set of objects (ending with the 1st parameter) and
# grep the output for the 2nd parameter
function nmgrep ()
{
	for i in $( find \. -name \*$1 ); do
		if [[ ! -e $i ]]; then
			continue;
		fi
		nm $i | grep $2 > /tmp/foo.tmp;
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


alias ag="ack-grep"
alias eu="erwin_update"
alias gr="find . | grep -v .svn | xargs grep -Iisn"
alias hgr="find . | grep -v .svn | grep \\.h$ | xargs grep -iIsHn"
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
alias mux="make_fn ux"
alias l="ls"
alias s="sudo"
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

# cd shortcuts
alias cdbin="cd $L4BIN"
alias cdf="cd $L4REDIR/pkg/ferret"
alias cdi="cd /home/doebel/src/images/l4re/root/l4re"
alias cdlx="cd /home/doebel/src/tudos/trunk/l4linux-2.6/"
alias cdlx18="cd /home/doebel/src/linux/linux-2.6.18"
alias cdmag="cd $L4REDIR/tool/mag.py"
alias cdmk="cd $L4REDIR/mk"
alias cdn="cd /home/doebel/src/workspace/python/wx/nuggan"
alias cdo="cd $MYL4DIR/pkg/ore"
alias dde="cd $L4REDIR/pkg/dde/linux26/"
alias cdre="cd $L4REDIR/pkg"
alias cdv="cd $L4REDIR/pkg/valgrind"
alias fiascodev="cd /home/doebel/src/tudos/trunk/kernel/fiascodev"

alias vless='/usr/share/vim/vim72/macros/less.sh'
alias vl='vless'
alias la='ls -la'
