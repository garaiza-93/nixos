#!/usr/bin/env bash

# Check if a file path is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

file_path="$1"

# Check if the file exists
if [ ! -e "$file_path" ]; then
    echo "Error: File not found at $file_path"
    exit 1
fi

# Execute Git commands
git add --intent-to-add "$file_path"
git update-index --skip-worktree --assume-unchanged "$file_path"

echo "Git commands executed successfully for $file_path"
