# load nvm
export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"

# keep 1000 lines of history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

unsetopt BEEP
zle_highlight=('paste:none')

# basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
# auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source ~/.aliases
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship prompt
eval "$(starship init zsh)"

export PATH="$PATH:/Users/timeitel/development/flutter/bin"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/timeitel/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/timeitel/google-cloud-sdk/path.zsh.inc'; fi
