#!/bin/bash
# Run these scripts to set up your dotfiles!
# curl -Lks https://raw.githubusercontent.com/santihdzs/dotfiles/main/.setup.sh | bash

# Useful env variables
DOTFILES=.dotfiles
REMOTE=git@github.com:santihdzs/dotfiles.git

# Add alias
alias config='/usr/bin/git --git-dir=$HOME/$DOTFILES/ --work-tree=$HOME'

# Add to .gitignore to prevent recursion issues
echo "$DOTFILES" >> $HOME/.gitignore

# Clone dotfiles repo
git clone --bare $REMOTE $HOME/$DOTFILES

# Checkout files
config checkout

# If checkout fails, backup existing dotfiles
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    echo "Backing up pre-existing dotfiles...";
    config checkout 2>&1 | egrep "\s+\." | awk '{print $1}' | while read -r file; do
        # Make directory to backup existing config
        dir=$(dirname ".dotfiles-backup/$file")
        mkdir -p "$dir"

        # Move conflicting files to backup dir
        mv "$file" ".dotfiles-backup/$file"
    done
fi;

# Final checkout after backing up
config checkout

# Hide untracked files from 'status' list
config config status.showUntrackedFiles no
echo "Your dotfiles are set up!"