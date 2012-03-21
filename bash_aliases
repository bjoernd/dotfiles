# Aliases
# ssh
alias kiwi="ssh -X bd1@kiwi.inf.tu-dresden.de"
alias loki="ssh bjoern@loki.rshc.de"
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

function sodump()
{
	sobjdump -lSCd $@ | less;
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
alias msparc="make_fn sparc"
alias mcmsp="make_fn sparc cleanall && make_fn sparc"
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
alias pwr_perf="sudo $HOME/local/bin/cpu perf"
alias pwr_save="sudo $HOME/local/bin/cpu power"

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
alias cdp="cd $L4REDIR/pkg/plr/server/src"
alias cdv="cd $L4REDIR/pkg/valgrind"
alias fiascodev="cd $FIASCO_DEV_BASE/$FIASCO_SRC"
alias asteroid="cd /home/doebel/data/work/Projekte/ASTEROID"

alias vless='/usr/share/vim/vim72/macros/less.sh'
alias vl='vless'
alias la='ls -la'

# sparc binutils
alias saddr2line="sparc-elf-addr2line"
alias sar="sparc-elf-ar"
alias sas="sparc-elf-as"
alias sc++="sparc-elf-c++"
alias sc++-filt="sparc-elf-c++filt"
alias scpp="sparc-elf-cpp"
alias sg++="sparc-elf-g++"
alias sgcc="sparc-elf-gcc"
alias sgcc-4.4.2="sparc-elf-gcc-4.4.2"
alias sgccbug="sparc-elf-gccbug"
alias sgcov="sparc-elf-gcov"
alias sgdb="sparc-elf-gdb"
alias sgdbtui="sparc-elf-gdbtui"
alias sgprof="sparc-elf-gprof"
alias sinsight="sparc-elf-insight"
alias sld="sparc-elf-ld"
alias snm="sparc-elf-nm"
alias sobjcopy="sparc-elf-objcopy"
alias sobjdump="sparc-elf-objdump"
alias sranlib="sparc-elf-ranlib"
alias sreadelf="sparc-elf-readelf"
alias ssize="sparc-elf-size"
alias sstrings="sparc-elf-strings"
alias sstrip="sparc-elf-strip"
