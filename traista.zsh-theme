# traistă theme v0.0.1
# https://github.com/gni/traista

local ret_status="%(?:%{$fg[green]%}⦿:%{$fg_bold[red]%}⦾)"
PROMPT='${ret_status}%{$fg_bold[blue]%}%p %{$fg_bold[blue]%}%c %{$reset_color%}'
RPROMPT='$(nvm_prompt_info) $(git_prompt_info)%'
ZSH_THEME_NVM_PROMPT_PREFIX="%{$fg_bold[green]%}%B⬢%b%{$reset_color%} "
ZSH_THEME_NVM_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[green]%}±%{$reset_color%}%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
