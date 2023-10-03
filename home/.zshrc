# load nvm
export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh/history

unsetopt BEEP
zle_highlight=('paste:none')

# basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
# auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source ~/.config/zsh/aliases
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship prompt
eval "$(starship init zsh)"

# command history and completion
bindkey '^L' autosuggest-execute
bindkey '^[^L' forward-word
bindkey '^K' up-history
bindkey '^J' down-history
bindkey '^r' history-incremental-search-backward

# delete forward word
bindkey '^d' kill-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# nvim-dap rust
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
