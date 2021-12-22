#!/bin/bash

# usage:
# convert-directory <path_to_directory> <extension>

directory="$1"
extension="$2"

convertDirectory ()
  for file in `find "$directory" -type f -name "*.$extension"`;
  do
    echo "$file"
    cp $file "$file.backup"
    awk -f main.awk "$file.backup" > $file
    rm "$file.backup"
  done

convertDirectory  "$directory"
