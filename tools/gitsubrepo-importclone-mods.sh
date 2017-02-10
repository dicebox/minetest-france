#!/bin/sh


file_input="$1"


for repo in $(cat ${file_input}); do
  #echo "${repo}"
  git subrepo clone "${repo}" mods/"$(echo "${repo}" | rev | cut -d "." -f 2- | cut -d "/" -f 1 | rev)"
  read
done
