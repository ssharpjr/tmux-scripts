#!/bin/bash
# djdevmux.sh
# tmux script for django projects.
# Loads virtualenvs.
# Usage: djdevmux.sh <project name> <venv_name>

if [ -z "$1" ]
  then
    echo "No project specified"
    echo "Usage: $0 <project_name> <venv_name>"
    exit 0
fi

if [ -z "$2" ]
  then
    echo "No virtualenv name specified"
    echo "Usage: $0 <project_name> <venv_name>"
    exit 0
fi

PROJECT="$1"
VENV="$2"
# PROJECT_SUFFIX="_project"
DEV_FOLDER="/home/$(whoami)/dev/django"
PROJECT_FOLDER="$DEV_FOLDER/$PROJECT"
DEV_VENV_SUFFIX="_dev"
TEST_VENV_SUFFIX="_test"
DEV_SESSION="$2$DEV_VENV_SUFFIX"
TEST_SESSION="$2$TEST_VENV_SUFFIX"
TMUX_SESSION="Django-$PROJECT"

cd $PROJECT_FOLDER

tmux new-session -d -s $TMUX_SESSION  -n "$DEV_SESSION"

tmux new-window -t $TMUX_SESSION:2 -n "$TEST_SESSION"

tmux send-keys -t "$TMUX_SESSION:2" C-z "workon $TEST_SESSION; clear" Enter
tmux send-keys -t "$TMUX_SESSION:1" C-z "workon $DEV_SESSION; clear" Enter

tmux select-window -t $TMUX_SESSION:1
tmux -2 attach-session -t $TMUX_SESSION

