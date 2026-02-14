# traistă

Fast, async zsh prompt theme for [Oh My Zsh](https://ohmyz.sh/).

```
~/project  main +2 ~1 ?3 ↑1                                    12:34:56
❯
```

## Features

- **Async git** - single `git status` call, parsed in background, prompt never blocks
- **Two-line layout** - path and git info on line 1, clean input on line 2
- **Nerd Font icons** - `` branch icon, consistent glyph widths
- **Git status counts** - staged (`+`), modified (`~`), untracked (`?`), deleted (`-`), unmerged (`!`)
- **Ahead/behind** - `↑N` / `↓N` relative to remote
- **Exit status** - green `❯` on success, red `❯` on failure
- **Right-aligned time** - color-coded by last exit status (blue ok, red error)
- **Detached HEAD** - shows tag name or short SHA

## Requirements

- [Oh My Zsh](https://ohmyz.sh/)
- A [Nerd Font](https://www.nerdfonts.com/) (JetBrains Mono, Fira Code, etc.)

## Install

```sh
git clone https://github.com/gni/traista ~/.oh-my-zsh/custom/themes/traista
```

Set in `.zshrc`:

```sh
ZSH_THEME="traista/traista"
```

Restart your shell.

Or install with [dotfiles](https://github.com/gni/dotfiles):

```sh
git clone https://github.com/gni/dotfiles ~/dotfiles
cd ~/dotfiles
make install
```

## Git Status Reference

| Symbol | Color | Meaning |
|--------|-------|---------|
| `+N` | green | Staged files |
| `~N` | yellow | Modified files (worktree) |
| `?N` | blue | Untracked files |
| `-N` | red | Deleted files |
| `!N` | magenta | Unmerged (conflicts) |
| `↑N` | green | Commits ahead of remote |
| `↓N` | red | Commits behind remote |

## License

MIT - see [LICENSE](LICENSE).
