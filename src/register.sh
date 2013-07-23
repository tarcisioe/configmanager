#!/bin/bash

CONFIGSROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! "$1" -a "$2" ]
then
    echo "$0: wrong number of arguments"
    exit
fi

if [ ! -e "$1" ]
then
    echo "$0: file $1 does not exist"
    exit
fi

if [ -h "$1" ]
then
    echo "$0: file $1 is already a symbolic link"
    exit
fi

newpath="${CONFIGSROOT}/files/$2"

if [ -e "$newpath" ]
then
    echo "$0: file $2 already exists"
fi

realpath="$(readlink -f $1)"
[[ "$realpath" =~ ^"$HOME"(/|$) ]] && realpath="~${realpath#$HOME}"

mv "$1" "$newpath"
ln -s "$newpath" "$1"
echo "$realpath" "$2" >> "${CONFIGSROOT}/mapping"
sort "${CONFIGSROOT}/mapping" >> "${CONFIGSROOT}/sorted"
mv "${CONFIGSROOT}/sorted" "${CONFIGSROOT}/mapping"
