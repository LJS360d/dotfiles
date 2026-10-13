# dotfiles

Managed with [chezmoi](https://www.chezmoi.io/). Targets Arch-based Linux (CachyOS) with GNOME.

```sh
chezmoi init --apply <repo-url>
```

### Required

| Package | Used by |
| --- | --- |
| `chezmoi` | applying this repo |
| `zsh` | shell (`.zshrc`, `config/zsh/`) |
| `sheldon` | zsh plugin manager (`config/sheldon/plugins.toml`) |
| `starship` | prompt (`config/starship.toml`) |
| `mise` | runtime/version manager, activated in `.zshrc` |
| `zoxide` | `cd` replacement, hooked in `.zshrc` |
| `fzf` | fuzzy finder, shell integration + `fzf-tab` |
| `git` | `.gitconfig` |
| `git-delta` | git pager and diff filter (`core.pager = delta`) |
| `alacritty` | terminal (`config/alacritty/`) |
| `ttf-firacode-nerd` | `FiraCode Nerd Font Mono` in alacritty and zed; also needed for starship icons |
| `nano` | `.nanorc` |

Sheldon fetches the zsh plugins itself on first shell start (`zsh-defer`, `zsh-completions`, `fzf-tab`, `zsh-autosuggestions`, `fast-syntax-highlighting`, `zsh-history-substring-search`), so there is nothing to install for those.

### Optional

`.zshrc` and the aliases check for these and fall back to the plain tool when missing.

| Package | Effect |
| --- | --- |
| `eza` | `ls`/`ll`/`la`/`lt` aliases, `fzf-tab` cd preview |
| `bat` | `cat` alias, man pager |
| `fd` | `fzf` default file command |
| `ripgrep` | `rgi` alias |
| `duf` | `df` alias |
| `dust` | `du` alias |
| `procs` | `ps` alias |
| `btop` | `top` alias |
| `yazi` | `y` alias |
| `tldr` | `help` alias |
| `neovim` | `$EDITOR` default |
| `xclip` | `clip` alias |
| `docker` | `docker-deepclean` alias |
| `ninja` | `n` alias |

### Apps

| Package | Used by |
| --- | --- |
| `zed` | editor (`config/zed/`); the `zed` alias calls `zeditor` |
| `discord` | `config/discord/` |

Zed also wants the *Material Icon Theme* extension, and language servers for the languages you use (`elixir-ls`, `tailwindcss-language-server` are configured).

### GNOME extensions

`gnome_extensions.conf` is a `dconf dump` of the extension settings. `chezmoi apply` loads it via `run_onchange_after_load-gnome-extensions.sh.tmpl` whenever it changes. Install the extensions it covers first:

`arcmenu`, `bluetooth-battery-indicator`, `clipboard-indicator`, `dash-to-dock`, `dash-to-panel`, `do-not-disturb-while-screen-sharing-or-recording`, `forge`, `gsconnect`, `gtk4-ding`, `notification-banner-reloaded`, `space-bar`, `system-monitor`, `user-theme`, `vitals`

Refresh the file after tweaking settings: `dconf dump /org/gnome/shell/extensions/ > $(chezmoi source-path)/gnome_extensions.conf`

## One-shot install

```sh
sudo pacman -S --needed chezmoi zsh sheldon starship mise zoxide fzf git git-delta \
  alacritty ttf-firacode-nerd nano \
  eza bat fd ripgrep duf dust procs btop yazi tldr neovim xclip
```

## Local overrides

Machine-specific shell config goes in `~/.config/zsh/local.zsh` (untracked, sourced last).
