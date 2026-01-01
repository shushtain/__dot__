#!/usr/bin/env bash

thumb_size=64
thumb_dir="$HOME/.cache/cliphist/thumbnails"
[ -d "$thumb_dir" ] || mkdir -p "$thumb_dir"

cliphist_list=$(cliphist list)
if [ -z "$cliphist_list" ]; then
    fuzzel -d --placeholder "clipboard is empty"
    rm -rf "$thumb_dir"
    exit 1
fi

read -r -d '' thumbnail <<EOF
# skip meta
/^[0-9]+\s<meta http-equiv=/ { next }

# match images
match(\$0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
  id=grp[1]
  ext=grp[3]
  thumb=id"."ext
  system("[ -f ${thumb_dir}/"thumb" ] || echo " id "\\\\\t | cliphist decode | magick - -thumbnail ${thumb_size}^ -gravity center -extent ${thumb_size} ${thumb_dir}/"thumb)
  print \$0"\0icon\x1f${thumb_dir}/"thumb
  next
}
1
EOF

item=$(echo "$cliphist_list" | gawk "$thumbnail" | fuzzel -d --counter --no-sort --with-nth 2)

exit_code=$?
if [ -z "$item" ] && [ "$exit_code" -ne 19 ] && [ "$exit_code" -ne 10 ]; then
    exit 1
fi

[ -z "$item" ] || echo "$item" | cliphist decode | wl-copy

find "$thumb_dir" -type f | while IFS= read -r thumbnail_file; do
    cliphist_item_id=$(basename "${thumbnail_file%.*}")
    if ! grep -q "^${cliphist_item_id}\s\[\[ binary data" <<<"$cliphist_list"; then
        rm "$thumbnail_file"
    fi
done
