#!/bin/bash

HOME_DIR=${HOME}
BACKUP_DIR="$HOME_DIR/name_backup"

# Create the backup directory if it doesn't already exist
mkdir -p "$BACKUP_DIR"

# Loop over dotfiles in the home directory
for dotfile in "$HOME_DIR"/.*; do
    # Skip the special directories . and ..
    if [[ "$dotfile" == "$HOME_DIR/." || "$dotfile" == "$HOME_DIR/.." ]]; then
        continue
    fi

    # Move each dotfile/dot-directory into the backup folder
    mv -- "$dotfile" "$BACKUP_DIR"
done

echo "Moved all dotfiles (excluding . and ..) from $HOME_DIR to $BACKUP_DIR"
