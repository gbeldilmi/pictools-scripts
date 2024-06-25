#! /usr/bin/env zsh

# This script copy the edit files used for a picture (given as first argument) to use it with other pictures (given as other
# arguments).

source /usr/local/etc/pictools.cfg

function usage() {
  echo "Usage: $0 <source_ref> <destination_refs>"
  echo "  Refs are the picture references without the prefix and extension."
}

if [ -z $2 ]; then
  echo "You must provide at least two arguments."
  usage
  exit 1
fi

source_ref=$1 # Source reference is the first argument
destination_refs=${@:2} # Destination references are the other arguments

setopt shwordsplit

find . -maxdepth 1 -type f -name "$PT_PIC_PREFIX$source_ref*" | while read file; do
  format=$(echo $file | sed 's/.*\.//')
  ## Check file format
  if [[ " ${PT_EDIT_FORMATS[@]} " =~ $format ]]; then
    for dest in $destination_refs; do
      new_file=$(echo $file | sed "s/$source_ref/$dest/")
      echo "Copying $file to $new_file"
      cp $file $new_file
    done
  fi
done

unsetopt shwordsplit

echo "Done."
