#!/bin/bash
set -euo pipefail
(( $# == 0 )) || { echo 'Usage: bash install.sh' >&2; exit 2; }
source_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
data=${XDG_DATA_HOME:-}
[[ $data == /* ]] || data="$HOME/.local/share"
app_dir="$data/omarchy-netflix"
desktop_dir="$data/applications"
icon_dir="$data/icons/hicolor/64x64/apps"
install -d -- "$app_dir" "$desktop_dir" "$icon_dir"
install -m 644 -- "$source_dir/netflix.png" "$icon_dir/omarchy-netflix.png"
install -m 755 -- "$source_dir/omarchy-netflix" "$app_dir/omarchy-netflix"

# Two escaping layers: Exec argument quoting, followed by desktop string escaping.
exec_arg="$app_dir/omarchy-netflix"
exec_arg=${exec_arg//\\/\\\\}
exec_arg=${exec_arg//\"/\\\"}
exec_arg=${exec_arg//\$/\\\$}
exec_arg=${exec_arg//\`/\\\`}
exec_arg=${exec_arg//%/%%}
exec_arg="\"$exec_arg\""
exec_arg=${exec_arg//\\/\\\\}
exec_arg=${exec_arg//$'\n'/\\n}
exec_arg=${exec_arg//$'\r'/\\r}
exec_arg=${exec_arg//$'\t'/\\t}
tmp=$(mktemp "$desktop_dir/.omarchy-netflix.XXXXXX")
trap 'rm -f -- "$tmp"' EXIT
cat > "$tmp" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Netflix
Comment=Unofficial launcher: watch Netflix in a dedicated Chromium window
Exec=$exec_arg
Icon=omarchy-netflix
Terminal=false
StartupNotify=true
StartupWMClass=omarchy-netflix
Categories=AudioVideo;Video;
Keywords=Netflix;Movies;TV;Streaming;
EOF
chmod 644 "$tmp"
mv -f -- "$tmp" "$desktop_dir/omarchy-netflix.desktop"
if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$desktop_dir" >/dev/null 2>&1 || true
fi
printf '%s\n' 'Installed. Search for Netflix in your app launcher.'
if ! command -v chromium >/dev/null 2>&1; then
  printf '%s\n' 'Chromium is required before playback. Install it through Omarchy.'
fi
