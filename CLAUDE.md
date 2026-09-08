# CLAUDE.md

Instructions and context for Claude Code when working in this dotfiles repository.

## Repository Structure

This is a macOS-first dotfiles repo managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package that gets symlinked into `$HOME`.

```
bat/        → bat config & themes
bin/        → custom executables (e.g. compliance-packs)
browser/    → browser extension config (Vimium options)
curl/       → .curlrc
fish/       → Fish shell config, functions, completions
fonts/      → fonts (not stowed, manual install)
ghostty/    → Ghostty terminal config (.config/ghostty/config)
git/        → .gitconfig, .gitmessage
homebrew/   → .Brewfile
mise/       → .config/mise/config.toml
security/   → .gnupg/, .ssh/config
tmux/       → .tmux.conf, tmuxinator configs
tuicr/      → TUI Cider config (.config/tuicr/config.toml)
vim/        → .vimrc, .config/nvim/ (Neovim via LazyVim)
wezterm/    → .wezterm.lua
```

## Installation & Management

```sh
make              # Default: update everything + run gems + clean
make install      # Stow dotfiles, install brew/node packages (no update)
make update       # brew bundle + npm update
make brew         # Install Homebrew formulas/casks from .Brewfile (no upgrade)
make node_modules # Install global npm modules
make gems         # gem install global gems
make stow         # Symlink dotfiles only
make clean        # brew cleanup + gem cleanup + mise prune
make help         # List all targets
```

Stow packages (defined in Makefile): `bat bin curl fish ghostty git homebrew mise security tmux tuicr vim wezterm`

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

Mise manages global Node (`latest`) — see `mise/.config/mise/config.toml`. Per-project versions are set via `.mise.toml` or `.ruby-version` etc. in each project root. For Common Lisp, the Neovim setup invokes Roswell (`ros`) directly; install via Homebrew if needed.

**Global npm modules** are managed in the Makefile `global_node_modules` list (not the Brewfile): `neovim`, `@earendil-works/pi-coding-agent`, `typescript`, `typescript-language-server`.

## Neovim Setup

Based on [LazyVim](https://www.lazyvim.org). Key files:

- `vim/.config/nvim/lua/config/lazy.lua` — plugin loader, LazyVim extras imports go here (between `lazyvim.plugins` and `plugins`)
- `vim/.config/nvim/lua/config/options.lua` — vim options
- `vim/.config/nvim/lua/config/keymaps.lua` — custom keymaps
- `vim/.config/nvim/lua/plugins/` — custom plugin specs

**Active LazyVim extras** (declared in `lazy.lua`, prefix `lazyvim.plugins.extras.`):
- `ai.claudecode`, `ai.copilot` — AI coding assistants
- `coding.mini-surround` — surround motions
- `lang.json`, `lang.markdown`, `lang.ruby`, `lang.rust`, `lang.toml`, `lang.typescript`, `lang.typescript.biome` — language support (ruby = ruby-lsp + rubocop integration)
- `util.dot`, `util.gh` — dotfile filetype + GitHub integration

**Custom plugin specs** (in `lua/plugins/`):
- `catppuccin.lua`, `colorscheme.lua` — Catppuccin colorscheme setup
- `disabled.lua` — disables flash.nvim
- `lisp.lua` — Common Lisp (see below)
- `lsp.lua` — general LSP tweaks
- `ruby.lua` — Gusto RuboCop/LSP configuration
- `snacks.lua` — Snacks.nvim config
- `treesitter.lua` — Treesitter options

**Common Lisp plugins** (declared in `lua/plugins/lisp.lua`):
- `vlime/vlime` — REPL, debugger with restarts, inspector, XREF (via Swank)
- `julienvincent/nvim-paredit` — structural s-expression editing

**Theme:** Catppuccin Mocha throughout (Neovim, tmux, WezTerm, bat). Neovim relies on Catppuccin's default flavor (Mocha) rather than setting it explicitly.

When adding new LazyVim extras, add them to `lazy.lua` between the `lazyvim.plugins` and `plugins` imports — not as standalone plugin files. This avoids the import order warning.

## Rules & Conventions

- **Always verify plugin/config options against official docs before writing.** Do not guess at option names — check the plugin's README or docs site first.
- **Brewfile sections** are organized by category with fold markers. Keep entries alphabetical within each section.
- **Fish functions** live in `fish/.config/fish/functions/` — one function per file, named `<function>.fish`.
- **Fish completions** in `fish/.config/fish/completions/` — only add completions for tools actually installed in the Brewfile.
- **Global gems** are managed in the Makefile `global_gems` list, not the Brewfile.
- **`tmuxinator`** is installed via Homebrew, not as a global gem. It was a global gem
  until 2026-08-23, but gems live inside a specific mise ruby install — when
  `/etc/mise/config.toml`'s `ruby = "latest"` moved from 4.0.5 to 4.0.6, the gem stayed
  behind and only a stale mise shim remained, so `tmuxinator` failed with "No version is
  set for shim". The Homebrew formula vendors its own ruby and is immune to mise ruby churn.
- The `.vimrc` exists for occasional vanilla Vim use — Neovim is the primary editor.
- **Do not commit `.claude/settings.local.json`** — it is gitignored as it gets auto-modified by Claude Code sessions.
