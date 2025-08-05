#!/bin/bash

# Store theme in a temp file
THEME_FILE="${HOME}/.tmux/theme"

if [[ ! -f $THEME_FILE ]]; then
  echo "dark" > $THEME_FILE
fi

THEME=$(cat $THEME_FILE)

if [[ "$THEME" == "dark" ]]; then
  tmux source-file ~/.tmux/tmux.light.conf
  echo "light" > $THEME_FILE
  tmux display-message "Switched to light theme"
else
  tmux source-file ~/.tmux/tmux.dark.conf
  echo "dark" > $THEME_FILE
  tmux display-message "Switched to dark theme"
fi
