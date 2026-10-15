# dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

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
| `nano` | `$EDITOR`, `.nanorc` |

Fonts ship in this repo and land in `~/.local/share/fonts/`: `MesloLGS NF` (active) and `FiraCode Nerd Font Mono`. Switch by changing the family in `config/alacritty/alacritty.toml` and `config/zed/settings.json` (zed buffer + terminal).

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
  alacritty nano \
  eza bat fd ripgrep duf dust procs btop yazi tldr xclip
```

### Debian / Ubuntu (24.04+)

apt covers most of it; the rest comes from upstream installers into `~/.local/bin` (make sure it is on `PATH`).

```sh
sudo apt install zsh zoxide git git-delta alacritty nano \
  eza bat fd-find ripgrep duf btop tldr xclip curl

mkdir -p ~/.local/bin
# Debian renames these binaries; the aliases look for the upstream names
ln -sf /usr/bin/batcat ~/.local/bin/bat
ln -sf /usr/bin/fdfind ~/.local/bin/fd

sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin
curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
  | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
curl https://mise.run | sh
~/.local/bin/mise use -g fzf dust procs yazi  # apt fzf is too old for `fzf --zsh` (needs 0.48+)

chsh -s "$(command -v zsh)"
```

## Local overrides

Machine-specific shell config goes in `~/.config/zsh/local.zsh` (untracked, sourced last).
