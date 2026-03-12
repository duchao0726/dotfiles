# oh-my-zsh Theme by Chao Du
# Fallback theme for servers without p10k
# inspired by Bureau

### Git status symbols
ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[green]%}±%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED=" %{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED=" %{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg_bold[red]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$fg[red]%}‼%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STASHED=" %{$fg[cyan]%}⚑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND=" %{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED=" %{$fg[red]%}⇕%{$reset_color%}"

_chao_git_branch() {
  local ref
  ref=$(command git symbolic-ref HEAD 2>/dev/null) ||
  ref=$(command git rev-parse --short HEAD 2>/dev/null) || return
  echo "${ref#refs/heads/}"
}

_chao_git_status() {
  local index status=""
  index=$(command git status --porcelain -b 2>/dev/null) || return
  echo "$index" | grep -q '^[AMRD]. '   && status+="$ZSH_THEME_GIT_PROMPT_STAGED"
  echo "$index" | grep -q '^.[MTD] '    && status+="$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  echo "$index" | grep -qE '^\?\? '     && status+="$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  echo "$index" | grep -q '^UU '        && status+="$ZSH_THEME_GIT_PROMPT_UNMERGED"
  command git rev-parse --verify refs/stash &>/dev/null && status+="$ZSH_THEME_GIT_PROMPT_STASHED"
  echo "$index" | grep -q '^## .*ahead'    && status+="$ZSH_THEME_GIT_PROMPT_AHEAD"
  echo "$index" | grep -q '^## .*behind'   && status+="$ZSH_THEME_GIT_PROMPT_BEHIND"
  echo "$index" | grep -q '^## .*diverged' && status+="$ZSH_THEME_GIT_PROMPT_DIVERGED"
  [[ -z "$status" ]] && status="$ZSH_THEME_GIT_PROMPT_CLEAN"
  echo "$status"
}

_chao_git_prompt() {
  local branch
  branch=$(_chao_git_branch) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$branch$(_chao_git_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Save $? before any precmd function overwrites it
_chao_last_exit=0
_chao_save_exit() { _chao_last_exit=$? }
precmd_functions=(_chao_save_exit $precmd_functions)

_chao_exit_indicator() {
  [[ $_chao_last_exit -eq 0 ]] || echo " %{$fg[red]%}[✗ $_chao_last_exit]%{$reset_color%}"
}

# Username and prompt symbol: red for root, normal for user
if [[ $EUID -eq 0 ]]; then
  _CHAO_USER="%{$fg[red]%}%n%{$reset_color%}"
  _CHAO_LIBERTY="%{$fg[red]%}#%{$reset_color%}"
else
  _CHAO_USER="%{$fg[blue]%}%n%{$reset_color%}"
  _CHAO_LIBERTY="%{$fg[green]%}$%{$reset_color%}"
fi

setopt prompt_subst

# user@host[✗ N] ~/path [±branch ●]
# HH:MM:SS $
PROMPT='${_CHAO_USER}@%{$fg[cyan]%}%m%{$reset_color%}$(_chao_exit_indicator) %{$fg[blue]%}%~%{$reset_color%} $(_chao_git_prompt)
%{$fg[green]%}%*%{$reset_color%} ${_CHAO_LIBERTY} '
