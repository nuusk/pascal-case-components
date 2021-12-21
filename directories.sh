#!/bin/bash

directory=""

browsefolders ()
  for vueFile in `find ~/Code/n9/web/src -type f -name "*.vue"`;
  do
    echo "$vueFile"
    cp $vueFile "$vueFile.backup"
    awk -f main.awk "$vueFile.backup" > $vueFile
    rm "$vueFile.backup"
  done

browsefolders  "$directory"
