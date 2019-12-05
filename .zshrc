# ----------------------------
# ------  zsh config  --------
# ----------------------------
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob
bindkey -e

# Autocompletion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' menu select
setopt completealiases

# Case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  

# Arrow up to search beginning of word
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;6C" forward-word
bindkey "^[[1;6D" backward-word

# Directories
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi


# Color for autocompletion
zmodload zsh/complist
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

autoload -Uz compinit
autoload -U colors && colors
compinit



# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       history-beginning-search-backward
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     history-beginning-search-forward
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -N --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi



# Prompt Color Table Z shell
 fg_black=$'\e[0;30m'
 fg_red=$'\e[0;31m'
 fg_green=$'\e[0;32m'
 fg_brown=$'\e[0;33m'
 fg_blue=$'\e[0;34m'
 fg_purple=$'\e[0;35m'
 fg_cyan=$'\e[0;36m'
 fg_lgray=$'\e[0;37m'
 fg_dgray=$'\e[1;30m'
 fg_lred=$'\e[1;31m'
 fg_lgreen=$'\e[1;32m'
 fg_yellow=$'\e[1;33m'
 fg_lblue=$'\e[1;34m'
 fg_pink=$'\e[1;35m'
 fg_lcyan=$'\e[1;36m'
 fg_white=$'\e[1;37m'
 #Text Background Colors
 bg_red=$'\e[0;41m'
 bg_green=$'\e[0;42m'
 bg_brown=$'\e[0;43m'
 bg_blue=$'\e[0;44m'
 bg_purple=$'\e[0;45m'
 bg_cyan=$'\e[0;46m'
 bg_gray=$'\e[0;47m'
 #Attributes
 at_normal=$'\e[0m'
 at_bold=$'\e[1m'
 at_italics=$'\e[3m'
 at_underl=$'\e[4m'
 at_blink=$'\e[5m'
 at_outline=$'\e[6m'
 at_reverse=$'\e[7m'
 at_nondisp=$'\e[8m'
 at_strike=$'\e[9m'
 at_boldoff=$'\e[22m'
 at_italicsoff=$'\e[23m'
 at_underloff=$'\e[24m'
 at_blinkoff=$'\e[25m'
 at_reverseoff=$'\e[27m'
 at_strikeoff=$'\e[29m'


# ---------------------------------------------------------------------------------------------------- 
# ------------------------------------  git related prompt  ------------------------------------------
# ---------------------------------------------------------------------------------------------------- 
setopt prompt_subst

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL=""
GIT_PROMPT_PREFIX=""
GIT_PROMPT_SUFFIX=""
GIT_PROMPT_AHEAD="%{$fg[red]%}+NUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}-NUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}● %{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}● %{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}● %{$reset_color%}"


# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}


# Show different symbols as appropriate for various Git repository states
parse_git_state() {

  # Compose this value via multiple conditional appends.
  local GIT_STATE=""

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi

  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}

# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  if [ -n "$git_where" ] 
  then
      echo "[%{$reset_color%}$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[white]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX%{$maincolor%}]─"
  fi
}

# ---------------------------------------------------------------------------------------------------- 
# ------------------------------------ End of git related prompt  ------------------------------------
# ---------------------------------------------------------------------------------------------------- 


# ----------------------------
# --------  Prompt  ----------
# ----------------------------

local smiley="%(?,,%{$fg[red]%} :( %{$reset_color%})"


if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ];
then
        maincolor=$fg_green
else
        maincolor=$fg_blue
fi


precmd () {
        rehash
        GITpart=$(git_prompt_string)
        datetime=$(date +%H:%M:%S)
        nb_char_var=$(echo ${GITpart}${datetime}${USER}${HOST} | sed 's/%{[^%]*%}//g' | wc -m)
        ((nb=COLUMNS - nb_char_var - 16))
        dash=$(printf "%${nb}s\n" "" | sed s/" "/"─"/g)
PROMPT="%{$maincolor%} ┌────[%{$reset_color%}%n@%M%{$maincolor%}]${dash}${GITpart}[%{$reset_color%}%{$datetime%}%{$maincolor%}]────┐
 └───> %{$reset_color%}${smiley}%~ %(!.#.$) "

 echo -ne "\033]0;$(pwd)\007"
}


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

cd.. () {
 cd ..
}


# Extract any archive file
extract () {
	if [ -f $1 ] ; then
	case $1 in
		*.tar.bz2) tar xvjf $1 ;;
		*.tar.gz) tar xvzf $1 ;;
        *.tar.xz) tar -xf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xvf $1 ;;
		*.tbz2) tar xvjf $1 ;;
		*.tgz) tar xvzf $1 ;;
		*.zip) foldername="${1%.*}"
               mkdir "$foldername" 
               unzip $1 -d "$foldername";;
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



LS_COLORS=$LS_COLORS:'di=1;34:' ; export LS_COLORS
export EDITOR="vim"

