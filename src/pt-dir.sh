#! /usr/bin/env zsh

# This script automatically creates a directory for each picture file format in the current directory and subdirectories and
# moves corresponding files to the right directory.

source /usr/local/etc/pictools.cfg

find . -type f  | while read file; do
  directory=$(dirname $file)
  format=$(echo $file | sed 's/.*\.//')
  # Check file format
  if [[ " ${PT_FORMATS[@]} " =~ $format ]]; then
    if [[ " ${PT_EDIT_FORMATS[@]} " =~ $format ]]; then
      format=$PT_PIC_RAW_FORMAT # Move the edit file with other raw files
    fi
    # Check if the file is already in the right directory
    if [ $(basename $directory) != $format ]; then
      new_directory=$directory/$format
      mkdir -p $new_directory; mv $file $new_directory
    fi
  fi
done

echo "Done."
