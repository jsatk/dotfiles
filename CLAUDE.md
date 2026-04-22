# CLAUDE.md

Instructions and context for Claude Code when working in this dotfiles repository.

## Repository Structure

This is a macOS-first dotfiles repo managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package that gets symlinked into `$HOME`.

```
bat/        → bat config & themes
curl/       → .curlrc
fish/       → Fish shell config, functions, completions
fonts/      → fonts (not stowed, manual install)
git/        → .gitconfig, .gitmessage, .gitignore, .gitattributes
homebrew/   → .Brewfile
lisp/       → .sbclrc (Common Lisp / SBCL)
mail/       → mutt, mbsync, msmtp, notmuch (intentionally not stowed)
mise/       → .config/mise/config.toml
security/   → .gnupg/, .ssh/config
tmux/       → .tmux.conf, tmuxinator configs
vim/        → .vimrc, .config/nvim/ (Neovim via LazyVim)
weechat/    → weechat configs
wezterm/    → .wezterm.lua
```

## Installation & Management

```sh
make          # Default: update everything + run gems + clean
make install  # Stow dotfiles, install brew/node packages (no update)
make update   # brew bundle + npm update
make gems     # gem install global gems
make stow     # Symlink dotfiles only
make clean    # brew cleanup
make help     # List all targets
```

Stow packages (defined in Makefile): `bat curl fish git homebrew lisp mise security tmux vim weechat wezterm`

`mail` is intentionally excluded from stow — the config exists for reference but mutt is not actively used.

## Key Tools

| Tool | Purpose | Config |
|---|---|---|
| Fish | Shell | `fish/.config/fish/` |
| Neovim | Editor (`$EDITOR=nvim`) | `vim/.config/nvim/` |
| LazyVim | Neovim distribution | `vim/.config/nvim/lua/` |
| Mise | Language version manager | `mise/.config/mise/config.toml` |
| WezTerm | Terminal emulator | `wezterm/.wezterm.lua` |
| Tmux | Terminal multiplexer | `tmux/.tmux.conf` |
| Git-delta | Diff pager | configured in `git/.gitconfig` |
| Zoxide | Directory jumping (`z`) | initialized in `config.fish` |

## Language Management

Mise manages all language versions globally (`node`, `python`, `ruby`, `rust` — all `latest`). SBCL is installed via Homebrew (not supported by mise). Per-project versions are set via `.mise.toml` or `.ruby-version` etc. in each project root.

## Neovim Setup

Based on [LazyVim](https://www.lazyvim.org). Key files:

- `vim/.config/nvim/lua/config/lazy.lua` — plugin loader, LazyVim extras imports go here (between `lazyvim.plugins` and `plugins`)
- `vim/.config/nvim/lua/config/options.lua` — vim options
- `vim/.config/nvim/lua/config/keymaps.lua` — custom keymaps
- `vim/.config/nvim/lua/plugins/` — custom plugin specs

**Active LazyVim extras** (declared in `lazy.lua`):
- `lazyvim.plugins.extras.lang.ruby` — ruby-lsp, rubocop integration

**Common Lisp plugins** (declared in `lua/plugins/lisp.lua`):
- `vlime/vlime` — REPL, debugger with restarts, inspector, XREF (via Swank)
- `julienvincent/nvim-paredit` — structural s-expression editing

**Theme:** Catppuccin Mocha throughout (Neovim, tmux, WezTerm, bat).

When adding new LazyVim extras, add them to `lazy.lua` between the `lazyvim.plugins` and `plugins` imports — not as standalone plugin files. This avoids the import order warning.

## Rules & Conventions

- **Always verify plugin/config options against official docs before writing.** Do not guess at option names — check the plugin's README or docs site first.
- **Brewfile sections** are organized by category with fold markers. Keep entries alphabetical within each section.
- **Fish functions** live in `fish/.config/fish/functions/` — one function per file, named `<function>.fish`.
- **Fish completions** in `fish/.config/fish/completions/` — only add completions for tools actually installed in the Brewfile.
- **Global gems** are managed in the Makefile `global_gems` list, not the Brewfile.
- **`tmuxinator`** is managed as a global gem, not via Homebrew.
- The `.vimrc` exists for occasional vanilla Vim use — Neovim is the primary editor.
- **Do not commit `.claude/settings.local.json`** — it is gitignored as it gets auto-modified by Claude Code sessions.
