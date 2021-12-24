export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Aliases
alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias lt='ls --human-readable --size -1 -S --classify'
alias l.='ls -d .* --color=auto'
alias left='ls -t -1'
alias zs='source ~/.zshrc'
alias c='code '
alias cls='clear'
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

# Spaceship prompt
SPACESHIP_GIT_SYMBOL=''
SPACESHIP_GIT_BRANCH_PREFIX=''
SPACESHIP_GIT_PREFIX='['
SPACESHIP_GIT_SUFFIX='] '
SPACESHIP_GIT_BRANCH_SUFFIX=''
SPACESHIP_GIT_STATUS_PREFIX=''
SPACESHIP_GIT_STATUS_SUFFIX=''
SPACESHIP_CHAR_SYMBOL=❯
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_HG_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_ELM_SHOW=false
SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_XCODE_SHOW_LOCAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_JULIA_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_DOCKER_CONTEXT_SHOW=false
SPACESHIP_AWS_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_VENV_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_DOTNET_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_TERRAFORM_SHOW=false
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_JOBS_SHOW=false
SPACESHIP_EXEC_TIME_SHOW=false

eval "$(starship init zsh)"
