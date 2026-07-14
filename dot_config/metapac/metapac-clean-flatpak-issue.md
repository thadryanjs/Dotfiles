# Metapac Clean Flatpak Issue

## Problem
Running `metapac clean` tried to uninstall Discord, Vivaldi, Firefox, Signal, SignalCli, and Ferdium flatpaks despite them being defined in config files.

## Root Cause
**Package name mismatch between installed and configured state:**
- Installed packages: `system:com.discordapp.Discord`
- Config defined: `system:com.discordapp.Discord/x86_64/stable`

The `/x86_64/stable` arch/channel suffix prevented metapac from matching installed packages to config definitions, causing them to be marked as unmanaged.

## Solution
1. Fixed TOML syntax: Converted multiline inline tables (`flatpak = { ... }`) to proper TOML table headers (`[flatpak]`)
2. Removed package name suffixes in `groups/bases/base-arch-gnome.toml` to match installed package names exactly

## Files Modified
- `groups/bases/base-arch-gnome.toml` — Fixed TOML syntax and package names
- `groups/darlene/arch/main.toml` — Fixed TOML syntax
- `groups/bases/base-ubuntu-studio.toml` — Fixed TOML syntax (was already valid)

## Verification
`metapac unmanaged` no longer shows flatpak packages, and `metapac clean` completes without warnings.
