eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ $PWD == $HOME ]]; then
    cd $TMTL_START_PATH
fi

# select file or foler
# FZF preview window
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# cd
# FZF <A-c> print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# make fzf use rg to respect gitignore
export FZF_DEFAULT_COMMAND='rg --files --hidden --no-require-git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --exclude node_modules -td"
