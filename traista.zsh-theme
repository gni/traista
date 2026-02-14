# traistă theme v2.0.0
# https://github.com/gni/traista
#
# Fast, async two-line prompt with Nerd Font icons.
# Requires: oh-my-zsh, a Nerd Font patched terminal font.

# ---------------------------------------------------------------------------
#  Async git handler — runs in a forked subshell via oh-my-zsh async system
# ---------------------------------------------------------------------------
function _traista_git_info() {
  emulate -L zsh

  local raw
  raw="$(GIT_OPTIONAL_LOCKS=0 command git status --porcelain=v1 -b 2>/dev/null)" || return 0

  local -i staged=0 modified=0 untracked=0 deleted=0 unmerged=0
  local -i ahead=0 behind=0
  local branch=""

  # Split into lines
  local -a lines=("${(@f)raw}")

  # Parse header: ## branch...origin/branch [ahead N, behind M]
  local header="${lines[1]}"
  if [[ "$header" =~ '## (.+)\.\.\.(.+)' ]]; then
    branch="${match[1]}"
  elif [[ "$header" =~ '## (.+)' ]]; then
    branch="${match[1]}"
  fi

  # Handle "No commits yet on main"
  if [[ "$branch" =~ '^No commits yet on (.+)$' ]]; then
    branch="${match[1]}"
  fi

  # Handle detached HEAD
  if [[ "$branch" == *"(no branch)"* ]] || [[ "$branch" == "HEAD" ]]; then
    branch="$(GIT_OPTIONAL_LOCKS=0 command git describe --tags --exact-match HEAD 2>/dev/null \
              || GIT_OPTIONAL_LOCKS=0 command git rev-parse --short HEAD 2>/dev/null \
              || echo 'detached')"
  fi

  # Parse ahead/behind
  [[ "$header" =~ '\[ahead ([0-9]+)' ]] && ahead=${match[1]}
  [[ "$header" =~ 'behind ([0-9]+)' ]] && behind=${match[1]}

  # Parse file status lines (skip header)
  local line x y
  for line in "${lines[@]:1}"; do
    [[ -z "$line" ]] && continue
    x="$line[1]"
    y="$line[2]"

    # Untracked / ignored
    if [[ "$x" == "?" ]]; then
      (( untracked++ ))
      continue
    fi
    [[ "$x" == "!" ]] && continue

    # Unmerged
    if [[ "$x$y" == (UU|AA|DD|AU|UA|DU|UD) ]]; then
      (( unmerged++ ))
      continue
    fi

    # Index (staged) changes
    [[ "$x" == [AMRCD] ]] && (( staged++ ))

    # Worktree changes
    [[ "$y" == "M" ]] && (( modified++ ))
    [[ "$y" == "D" ]] && (( deleted++ ))
  done

  # Build output — pre-formatted with prompt escape sequences
  local result=""
  result+=" %{\033[0;36m%}⌥ ${branch:gs/%/%%}%{\033[0m%}"
  (( staged ))    && result+=" %{\033[0;32m%}+${staged}%{\033[0m%}"
  (( modified ))  && result+=" %{\033[0;33m%}~${modified}%{\033[0m%}"
  (( untracked )) && result+=" %{\033[0;34m%}?${untracked}%{\033[0m%}"
  (( deleted ))   && result+=" %{\033[0;31m%}-${deleted}%{\033[0m%}"
  (( unmerged ))  && result+=" %{\033[0;35m%}!${unmerged}%{\033[0m%}"
  (( ahead ))     && result+=" %{\033[0;32m%}↑${ahead}%{\033[0m%}"
  (( behind ))    && result+=" %{\033[0;31m%}↓${behind}%{\033[0m%}"

  echo -n "$result"
}

# ---------------------------------------------------------------------------
#  Prompt stub — reads cached async output
# ---------------------------------------------------------------------------
function _traista_git_prompt() {
  echo -n "${_OMZ_ASYNC_OUTPUT[_traista_git_info]}"
}

# ---------------------------------------------------------------------------
#  Right-aligned time on line 1 — uses cursor positioning (no length math)
# ---------------------------------------------------------------------------
function _traista_right_time() {
  local time_len=${#${(%):-%*}}
  local col=$(( COLUMNS - time_len + 1 ))
  echo -n "%{\e[${col}G%}%(?.%{\033[0;34m%}.%{\033[0;31m%})%*%{\033[0m%}"
}

# ---------------------------------------------------------------------------
#  Register async handler with oh-my-zsh
# ---------------------------------------------------------------------------
_omz_register_handler _traista_git_info

# ---------------------------------------------------------------------------
#  Prompt
# ---------------------------------------------------------------------------
PROMPT='%{$fg_bold[blue]%}%~%{$reset_color%}$(_traista_git_prompt)$(_traista_right_time)
%(?:%{$fg[green]%}:%{$fg[red]%})❯%{$reset_color%} '

RPROMPT=

# ---------------------------------------------------------------------------
#  Clear oh-my-zsh git variables to prevent interference
# ---------------------------------------------------------------------------
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
