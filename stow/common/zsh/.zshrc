# Paths
export PATH="$HOME/.local/bin:$PATH"

# XDG base dirs (tidy)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Zsh completions
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump"

# Antidote
if [ -f "$HOME/.antidote/antidote.zsh" ]; then
  source "$HOME/.antidote/antidote.zsh"
fi

# Plugins
if command -v antidote >/dev/null 2>&1; then
  antidote load <<'PLUGINS'
zsh-users/zsh-completions
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
PLUGINS
fi

# Starship prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# aliases
alias activate="source .venv/bin/activate"
alias newvenv="python -m venv .venv"

# bun
if [ -s "$HOME/.bun/_bun" ]; then
  source "$HOME/.bun/_bun"
fi
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
