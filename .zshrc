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
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# aliases
alias sz='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'

alias g='git'
alias gcd='cd `git rev-parse --show-toplevel`'
alias gs='git status'
alias gpl='git pull'
alias gf='git fetch'
alias gps='git push'
alias ga='git add'
alias gaa='git add -A'
alias gu='git reset --mixed'
alias gc='git commit -m'
alias gl='git log --all --decorate --oneline --graph'
alias grb='git rebase'
alias gb='git branch'
alias gco='git checkout'
alias gmos='gf && git merge origin staging'
# dotfiles / config repo
alias config='git -C ~/.dotfiles'

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship prompt
eval "$(starship init zsh)"
