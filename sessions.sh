SESH="personal"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "code"
  tmux send-keys -t $SESH:code "nvim ." C-m

  tmux new-window -t $SESH -n "term" -d
  tmux send-keys -t $SESH:term "ls" C-m

  tmux new-window -t $SESH -n "ps" -d
  tmux send-keys -t $SESH:ps "ls" C-m
fi

SESH="etc"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "config"
  tmux send-keys -t $SESH:config "vc" C-m

  tmux new-window -t $SESH -n "term" -d
  tmux send-keys -t $SESH:term "ls" C-m
fi

tmux attach-session -t "personal"
