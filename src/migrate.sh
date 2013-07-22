#!/bin/bash

CONFIGSROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

OIFS="$IFS"
NIFS=$'\n'

IFS="$NIFS"

for line in $(cat mapping)
do
    IFS="${OIFS}"

    read dest src <<< ${line}

    src="${CONFIGSROOT}/files/${src}"

    if [ -e "$dest" -a ! -h "$dest" ]
    then
        rm "$dest"
        ln -s "$src" "$dest"
    fi

    IFS="${NIFS}"
done
