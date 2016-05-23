#!/bin/bash
tmux new-session -d -s dev -n server
tmux new-window -t dev -n project
tmux select-window -t dev:1
tmux attach-session -t dev
