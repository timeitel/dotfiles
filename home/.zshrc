# load nvm
export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"

# keep 1000 lines of history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh/.zsh_history

unsetopt BEEP
zle_highlight=('paste:none')

# basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
# auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source ~/.config/.aliases
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship prompt
eval "$(starship init zsh)"

bindkey '^L' autosuggest-execute
bindkey '^[^L' forward-word
bindkey '^H' autosuggest-clear
bindkey '^K' up-history
bindkey '^J' down-history
bindkey '^r' history-incremental-search-backward
