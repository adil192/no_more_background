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

# Use the flutter_launcher_icons package to generate icons as a starting point
echo "Generating icons with flutter_launcher_icons..."
dart run flutter_launcher_icons
echo

# Re-generate android icons because flutter_launcher_icons' are pixelated
echo "Replacing android icons"
function replace_android_drawables() {
  local size=$1
  local sizeName=$2
  echo "Resizing icon_android_bg.svg to ${sizeName} (${size}x${size})"
  rsvg-convert -o "android/app/src/main/res/drawable-${sizeName}/ic_launcher_background.png" assets/icon/icon_android_bg.svg -w $size -h $size
  echo "Resizing icon_android_fg.svg to ${sizeName} (${size}x${size})"
  rsvg-convert -o "android/app/src/main/res/drawable-${sizeName}/ic_launcher_foreground.png" assets/icon/icon_android_fg.svg -w $size -h $size
  echo "Resizing icon_android_mono.svg to ${sizeName} (${size}x${size})"
  rsvg-convert -o "android/app/src/main/res/drawable-${sizeName}/ic_launcher_monochrome.png" assets/icon/icon_android_mono.svg -w $size -h $size
}
replace_android_drawables 108 mdpi
replace_android_drawables 162 hdpi
replace_android_drawables 216 xhdpi
replace_android_drawables 324 xxhdpi
replace_android_drawables 432 xxxhdpi
function replace_android_mipmap() {
  local size=$1
  local sizeName=$2
  echo "Resizing icon.png to ${sizeName} (${size}x${size})"
  rsvg-convert -o "android/app/src/main/res/mipmap-${sizeName}/ic_launcher.png" assets/icon/icon.svg -w $size -h $size
}
replace_android_mipmap 48 mdpi
replace_android_mipmap 72 hdpi
replace_android_mipmap 96 xhdpi
replace_android_mipmap 144 xxhdpi
replace_android_mipmap 192 xxxhdpi
cp -v android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png metadata/en-US/images/icon.png
echo

echo "All done!"
