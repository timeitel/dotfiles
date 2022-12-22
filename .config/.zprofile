eval "$(/opt/homebrew/bin/brew shellenv)"
export START="/Users/timeitel/code"
if [[ $PWD == $HOME ]]; then
    cd $START
fi

# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH
