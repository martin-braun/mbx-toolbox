#!/bin/bash
#
# Common bash extension library.

# Skip when already sourced:
test ! $MBX_LIBLOAD_BASE || return
export MBX_LIBLOAD_BASE=1

###
# Ensure a command can be executed.
# Arguments:
#   $1 - command to check.
# Outputs:
#   Nothing.
# Returns:
#   0, if the command exists.
###
test-command() {
	command -v "$1" >/dev/null 2>&1
}
