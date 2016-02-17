# ZSH Theme
# inspired by dieter, bira and pure

typeset -A host_repr

# translate hostnames into shortened, colorcoded strings
host_repr=('dieter-ws-a7n8x-arch' "%{$fg_bold[green]%}ws" 'dieter-p4sci-arch' "%{$fg_bold[blue]%}p4")

# local time, color coded by last return code
time_enabled="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
time_disabled="%{$fg[green]%}%*%{$reset_color%}"
time=$time_enabled

# user part, color coded by privileges
local user="%{$fg[blue]%}%n%{$reset_color%}"

# Hostname part.  compressed and colorcoded per host_repr array
# if not found, regular hostname in default color
local host="%{$fg[blue]%}@${host_repr[$HOST]:-$HOST}%{$reset_color%}"

# @
local at="%{$fg[green]%}@%{$reset_color%}"

# Compacted $PWD
local pwd="%{$fg[blue]%}%~%{$reset_color%}"

local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi

### NVM
ZSH_THEME_NVM_PROMPT_PREFIX="%B⬡%b "
ZSH_THEME_NVM_PROMPT_SUFFIX=""

### Git [±master ▾●]
ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[green]%}±%{$reset_color%}%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"

# $
dl_sign_enabled="%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})$%{$reset_color%}"
dl_sign_disabled="%{$fg_bold[green]%}$%{$reset_color%}"
dl_sign=$dl_sign_enabled


# Left Prompt
PROMPT=' ${user}${host} ${pwd} $(git_prompt_info)
 ${time} ${dl_sign} '

# elaborate exitcode on the right when >0
return_code_enabled="%(?..%{$fg[red]%}%? <=%{$reset_color%})"
return_code_disabled=
return_code=$return_code_enabled

# Right Prompt
RPS1='${return_code}'

function accept-line-or-clear-warning () {
	if [[ -z $BUFFER ]]; then
		time=$time_disabled
		return_code=$return_code_disabled
		dl_sign=$dl_sign_disabled
	else
		time=$time_enabled
		return_code=$return_code_enabled
		dl_sign=$dl_sign_enabled
	fi
	zle accept-line
}
zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning

