#!/bin/bash
desktop_dir=~/Desktop
icon_theme="Papirus"  # zmień na swój motyw, np. "Adwaita", "Yaru", "Breeze"
size=48               # rozmiar ikony (dostępne: 16, 24, 32, 48, 64, itp.)

get_icon_path() {
  local mime=$1
  local icon_name=$(gio info -a standard::icon "$mime" 2>/dev/null | grep 'standard::icon' | cut -d "'" -f2 | cut -d ',' -f1)

  # fallback: sanitize MIME type to match icon filenames (e.g., text-plain)
  if [[ -z "$icon_name" ]]; then
    icon_name=${mime//\//-}
  fi

  # find icon path
  for dir in ~/.icons /usr/share/icons; do
    path=$(find "$dir/$icon_theme" -type f -path "*/${size}x${size}/*/${icon_name}.*" 2>/dev/null | head -n 1)
    [[ -n "$path" ]] && echo "$path" && return
  done

  echo ""  # fallback: brak ikony
}

printf "["

first=true
for file in "$desktop_dir"/*; do
  [[ -e "$file" ]] || continue
  name=$(basename "$file")

  # MIME type (text/plain, image/png, etc.)
  mime=$(file --mime-type -b "$file")

  icon_path=$(get_icon_path "$file")
  icon_path=${icon_path//\"/\\\"}  # escape

  # fallback do folderu
  if [[ -d "$file" && -z "$icon_path" ]]; then
    icon_path="/usr/share/icons/$icon_theme/${size}x${size}/places/folder.png"
  fi

  [[ "$first" == true ]] && first=false || printf ","
  printf '\n{"name":"%s","icon":"%s"}' "$name" "$icon_path"
done

printf "\n]\n"

