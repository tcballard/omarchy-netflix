#!/bin/bash
set -euo pipefail
(( $# == 0 )) || { echo 'Usage: bash uninstall.sh' >&2; exit 2; }
data=${XDG_DATA_HOME:-}
[[ $data == /* ]] || data="$HOME/.local/share"
rm -f -- "$data/applications/omarchy-netflix.desktop" "$data/omarchy-netflix/omarchy-netflix"
rm -f -- "$data/icons/hicolor/64x64/apps/omarchy-netflix.png"
rmdir -- "$data/omarchy-netflix" 2>/dev/null || true
if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$data/applications" >/dev/null 2>&1 || true
fi
printf '%s\n' 'Netflix launcher removed. Your Netflix browser profile and login data are preserved.'
