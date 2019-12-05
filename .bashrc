# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# ----------------------------
# --------  Aliasses  --------
# ----------------------------
alias ll='ls -l -h'
alias la='ls -A'
alias lt='ls -tr'
alias llt='ls -lhtr'
alias l='ls -CF'
alias tree="find . | sed 's/[^/]*\//|   /g;s/| *\([^| ]\)/+--- \1/'"
alias treed="find . -type d | sed 's/[^/]*\//|   /g;s/| *\([^| ]\)/+--- \1/'"

function f() { find * -iname "*$1*" | grep -i "$1"}
alias cp='cp -i'
alias cpp='rsync --progress -h'
alias diff='colordiff'
alias findduplicate='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate'
alias myip='curl http://bot.whatismyipaddress.com'
alias sl='ls'
alias recent='find -maxdepth 2 -type f -mtime -1 -printf "%T@-%Tk:%TM - %f\n" | sort -rn | cut -d- -f2-'
alias nano='nano -wc'
alias vi='vim'
alias weather='curl http://wttr.in'



# ----------------------------
# -------  Functions  --------
# ----------------------------
# Extract any archive file
extract () {
	if [ -f $1 ] ; then
	case $1 in
		*.tar.bz2) tar xvjf $1 ;;
		*.tar.gz) tar xvzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xvf $1 ;;
		*.tbz2) tar xvjf $1 ;;
		*.tgz) tar xvzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "don't know how to extract '$1'..." ;;
	esac
	else
		echo "'$1' is not a valid file!"
	fi
}

# Adds colors to man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}


# ----------------------------
# --------  Prompt  ----------
# ----------------------------

# Pick color of the line
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # When using ssh
    col="1;32"
else
    # When connected locally
    col="0;34"
fi

# Generate dash line for the prompt
gen_dash () {
        datetime=$(date +%H:%M:%S)
        nb_char_var=$(echo ${datetime}${USER}${HOSTNAME%%.*} | wc -m)
        ((nb=COLUMNS - nb_char_var - 16))
        printf "%${nb}s\n" "" | sed s/" "/"─"/g
}

# Prompt
PS1='\[\033[${col}m\] ┌────[\[\033[0;00m\]\u@\h\[\033[${col}m\]]$(gen_dash)[\[\033[0;00m\]\t\[\033[${col}m\]]────┐ \n └───>\[\033[0;00m\] ${PWD/#$HOME/~} \$ '


LS_COLORS=$LS_COLORS:'di=1;34:' ; export LS_COLORS
export EDITOR="vim"


