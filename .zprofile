eval "$(/opt/homebrew/bin/brew shellenv)"
export START="/Users/timeitel/code"
if [[ $PWD == $HOME ]]; then
    cd $START
fi
