#!/bin/bash
#
# Common bash extension library.

# Skip when already sourced:
test ! $MBX_LIBLOAD_EXT || return
export MBX_LIBLOAD_EXT=1

###
# Ensure a command can be executed
# Arguments:
#   $1 - command to check
# Outputs:
#   Nothing
# Returns:
#   0, if the command exists, 1 otherwise
###
test-command() {
	command -v "$1" >/dev/null 2>&1
}
