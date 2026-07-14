#!/bin/bash
SESSION="$1"
exec tmux attach-session -t "$SESSION"
