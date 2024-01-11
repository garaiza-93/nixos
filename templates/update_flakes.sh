#!/usr/bin/env bash

# Iterate through each file and subdirectory
for item in $(ls -A); do
    if [ -f "$item" ]; then
        # If it's a file, run nix flake update
        echo "Updating flake for file: $item"
        nix flake update
    elif [ -d "$item" ]; then
        # If it's a directory, enter it and run nix flake update
        echo "Entering directory: $item"
        cd "$item"
        nix flake update
        # Return to the original directory
        cd ..
    fi
done
