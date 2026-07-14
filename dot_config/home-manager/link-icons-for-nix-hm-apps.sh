#!/bin/bash

# 1. Create local directories if they don't exist
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons

# 2. Symlink Nix desktop entries (for search visibility)
echo "Linking desktop entries..."
ln -sf ~/.nix-profile/share/applications/*.desktop ~/.local/share/applications/

# 3. Symlink Nix icons (to fix generic gear icons)
echo "Linking icons..."
ln -sf ~/.nix-profile/share/icons/* ~/.local/share/icons/


