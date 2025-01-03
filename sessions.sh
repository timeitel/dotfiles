SESH="w"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "edit"
  tmux send-keys -t $SESH:edit "vc" C-m

  tmux new-window -t $SESH -n "ps" -d
  tmux send-keys -t $SESH:ps "ls" C-m
fi

tmux attach-session -t $SESH
