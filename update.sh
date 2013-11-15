#!/bin/bash

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOTDIR="${HOME}/.configmanager"

if [ "$1" ]
then
    if [ ! -e "$1" ]
    then
        echo "$0: directory does not exist"
        exit
    fi

    ROOTDIR="$1"
fi

cp "$THISDIR/src"/*.sh "$ROOTDIR/"
