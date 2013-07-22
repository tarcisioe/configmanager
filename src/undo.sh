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

    rm $dest
    cp $src $dest

    IFS="${NIFS}"
done
