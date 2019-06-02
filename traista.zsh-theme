# traistă theme v0.0.1
# https://github.com/gni/traista

local ret_status="%(?:%{$fg[green]%}🐢:%{$fg_bold[red]%}💀)"
PROMPT='${ret_status}%{$fg_bold[blue]%}%p %{$fg_bold[blue]%}%c %{$reset_color%}$(git_prompt_info)'
RPROMPT='$(nvm_prompt_info)'
ZSH_THEME_NVM_PROMPT_PREFIX="%{$fg_bold[green]%}%B⬢%b%{$reset_color%} "
ZSH_THEME_NVM_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}±%{$reset_color%}%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗%{$reset_color%}"
