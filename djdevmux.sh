#!/bin/bash
# djdevmux.sh
#
# Author: Stacey Sharp (github.com/ssharpjr)
# tmux script for django projects.
# Loads virtualenvs in separate tmux windows.
#
# Requires: tmux, virtualenv, virtualenvwrapper
#
# Assumes you have the following setup:
# * A django project folder
# * A virtualenv suffixed with "_dev" (project_dev)
# * A virtualenv suffixed with "_test" (project_test)
#
# Usage: djdevmux.sh <project name> [venv_name]
# If no venv_name is specified, 
# the project name will be used as the virtualenv.

# Check for args
if [ -z "$1" ]
  then
    echo "No project specified"
    echo "The project name should be the folder name your project is in."
    echo "Usage: $0 <project_name> [venv_name]"
    exit 0
fi

PROJECT="$1"

if [ -z "$2" ]
  then
    echo "No virtualenv specified"
    echo "Using $1 as the virtualenv"
    VENV="$PROJECT"
  else
    VENV="$2"
fi

# Assign Variables - Change as needed
DEV_FOLDER="/home/$(whoami)/dev/django"
PROJECT_FOLDER="$DEV_FOLDER/$PROJECT"
DEV_VENV_SUFFIX="_dev"
TEST_VENV_SUFFIX="_test"
DEV_SESSION="$VENV$DEV_VENV_SUFFIX"
VENV_DEV_HOME="$WORKON_HOME/$DEV_SESSION"
TEST_SESSION="$VENV$TEST_VENV_SUFFIX"
VENV_TEST_HOME="$WORKON_HOME/$TEST_SESSION"
TMUX_SESSION="Django-$PROJECT"

# Variable test
echo
echo "Environmental Sanity Check"
echo "--------------------------"
echo "PROJECT = $PROJECT"
echo "VENV = $VENV"
echo "WORKON_HOME = $WORKON_HOME"
echo "DEV_FOLDER = $DEV_FOLDER"
echo "PROJECT_FOLDER = $PROJECT_FOLDER"
echo "DEV_SESSION = $DEV_SESSION"
echo "TEST_SESSION = $TEST_SESSION"
echo "TMUX_SESSION = $TMUX_SESSION"
echo "VENV_DEV_HOME = $VENV_DEV_HOME"
echo "VENV_TEST_HOME = $VENV_TEST_HOME"
echo
echo "Starting tmux..."
sleep 1

# Variable Sanity Checks
if [ -z "$PROJECT" ]
  then
    echo
    echo "No project assigned"
    echo "Please check your project folder name"
    echo "Exiting"
    exit 0
fi
if [ -z "$VENV" ]
  then
    echo
    echo "No virtualenv assigned"
    echo "Please check your virtualenv name"
    echo "Exiting"
    exit 0
fi
if [ ! -d "$VENV_DEV_HOME" ]
  then
    echo
    echo "Cannot locate a virtualenv named $DEV_SESSION in $VENV_FOLDER"
    echo "Please verify the virtualenv exists"
    echo "Exiting"
    exit 0
fi
if [ ! -d "$VENV_TEST_HOME" ]
  then
    echo
    echo "Cannot locate a virtualenv named $TEST_SESSION in $VENV_FOLDER"
    echo "Please verify the virtualenv exists"
    echo "Exiting"
    exit 0
fi

# Start tmux
cd $PROJECT_FOLDER

tmux new-session -d -s $TMUX_SESSION  -n "$DEV_SESSION"

tmux new-window -t $TMUX_SESSION:2 -n "$TEST_SESSION"

tmux send-keys -t "$TMUX_SESSION:2" C-z "workon $TEST_SESSION; clear" Enter
tmux send-keys -t "$TMUX_SESSION:1" C-z "workon $DEV_SESSION; clear" Enter

tmux select-window -t $TMUX_SESSION:1

tmux -2 attach-session -t $TMUX_SESSION
