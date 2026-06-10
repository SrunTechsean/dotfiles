HISTFILE="$HOME/.zsh_history"    # Where to save history
HISTSIZE=10000                   # How many lines to keep in memory
SAVEHIST=10000                   # How many lines to save to disk
setopt SHARE_HISTORY             # Share history across terminals immediately
setopt HIST_IGNORE_DUPS          # Don't record duplicates
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space

# =============================================================================
#  VIM MODE & CURSOR FIXES
# =============================================================================
bindkey -v                       # Enable Vim Mode
export KEYTIMEOUT=1

# Restore standard keys that Vim mode breaks
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# Change cursor shape (Beam in Insert Mode, Block in Normal Mode)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q' # Block cursor
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q' # Beam cursor
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # Default to Insert Mode
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# =============================================================================
#  COMPLETION SETTINGS 
# =============================================================================
# Initialize completion system
autoload -Uz compinit
compinit

# Enable the "Interactive Menu"
zstyle ':completion:*' menu select

# Load menu keymap
zmodload zsh/complist

# Case insensitive completion 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Pretty colors for the completion list
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# =============================================================================
#  CUSTOM KEYBINDINGS
# =============================================================================
setopt MENU_COMPLETE

# Navigation inside the Menu (Ctrl+N/P)
bindkey -M menuselect '^n' down-line-or-history
bindkey -M menuselect '^p' up-line-or-history

bindkey -M menuselect '^y' accept-line
bindkey '^y' autosuggest-accept

# =============================================================================
#  PLUGINS 
# =============================================================================
HOMEBREW_PREFIX="/opt/homebrew"

if [ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi


# make zoxide start when opening zsh
eval "$(zoxide init --cmd cd zsh)"  #--cmd cd change the zoxide cmd from z to cd

# Making python also mean python3
alias python="python3"


# The Odin Project nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Open man pages in nvim
export MANPAGER='nvim +Man!'

# Load environment for uv (adds ~/.local/bin to PATH so the newer uv install is used)
. "$HOME/.local/bin/env"


