#!/usr/bin/env sh
#
# Text transform library.

# Skip when already sourced:
test ! $MBX_LIBLOAD_TT || return
export MBX_LIBLOAD_TT=1

###
# Transforms the given text into the lowercase format.
# Arguments:
#   $1 - text to transform.
# Outputs:
#   Text in lowercase format.
# Returns:
#   0, if the text conversion was successful, 1 otherwise.
###
tolower() {
	echo "$1" | awk '{print tolower($0)}'
}

###
# Transforms the given text into the uppercase format.
# Arguments:
#   $1 - text to transform.
# Outputs:
#   Text in lowercase format.
# Returns:
#   0, if the text conversion was successful, 1 otherwise.
###
toupper() {
	echo "$1" | awk '{print toupper($0)}'
}

