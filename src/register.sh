#!/bin/bash
# Copyright (c) 2013, Tarcísio E. M. Crocomo
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this list
# of conditions and the following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice, this
# list of conditions and the following disclaimer in the documentation and/or
# other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


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
