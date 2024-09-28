#!/bin/bash

# Define the path to the .bashrc file and its backup
BASHRC=$HOME/.bashrc
BACKUP=$HOME/.bashrc.bk

# Check if the .bashrc file exists
if [ -f "$BASHRC" ]; then
  # Move the .bashrc file to .bashrc.bk
  mv "$BASHRC" "$BACKUP"
  echo "Moved $BASHRC to $BACKUP"
else
  echo "$BASHRC does not exist"
fi
