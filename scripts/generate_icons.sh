#!/bin/bash

function announce {
    # Announces a command before running it
    echo ">>> $*"
    "$@"
}

# Convert all svg to png
for svg_file in assets/icon/*.svg; do
  png_file="${svg_file%.svg}.png"
  announce rsvg-convert -o "$png_file" "$svg_file"
done
echo

# Run icons_launcher script
announce dart run icons_launcher:create
echo

echo "All done!"
