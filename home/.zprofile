eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ $PWD == $HOME ]]; then
    cd $TMTL_START_PATH
fi

# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH

# select file or foler
# FZF preview window
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# cd
# FZF <A-c> print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
