#!/bin/bash

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOTDIR="${HOME}/.gitconfigs"

if [ "$1" ]
then
    if [ -e "$1" ]
    then
        echo "$0: directory already exists"
        exit
    fi

    ROOTDIR="$1"
fi

mkdir -p "$ROOTDIR/files"
touch "$ROOTDIR/mapping"
cp "$THISDIR/src"/*.sh "$ROOTDIR/"
