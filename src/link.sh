#!/bin/bash

CONFIGSROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

OIFS="$IFS"
NIFS=$'\n'

IFS="$NIFS"

for line in $(cat mapping)
do
    IFS="$OIFS"

    read dest src <<< $line

    eval dest=$dest
    src="${CONFIGSROOT}/files/${src}"
    dir="$(dirname "$dest")"

    if [ ! -e "$dest" ]
    then
        if [ ! -d "$dir" ]
        then
            mkdir -p "$dir"
        fi
        ln -s "$src" "$dest"
    fi

    IFS="$NIFS"
done
