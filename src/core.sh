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

CALLERROOT="$(cd "$(dirname "$0")" && pwd)"

MAPPING="${CALLERROOT}"/mapping

fail() {
    echo "$@" 1>&2
    exit -1
}

maptofile() {
    # This function applies a command for every line of a file, passing the line's
    # contents as arguments.
    while read line
    do
        $1 ${line}
    done < "$2"

    unset line
}

withsrcdest()
{
    # This function sets the variables "src" and "dest" according to the scripts
    # needs and calls a command with them set, unsetting them afterwards.
    args=( $@ )
    len=${#args[@]}
    command=${args[0]}
    read dest src <<< ${args[@]:1:$len}
    eval dest=$dest
    src="${CALLERROOT}/files/$src"

    $command

    unset args len command src dest
}

callonmapping()
{
    maptofile "withsrcdest $1" "$MAPPING"
}
