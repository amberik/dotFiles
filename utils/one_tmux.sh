#!/bin/bash
if tmux info &> /dev/null; then 
  tmux atta
else
  tmux
fi
