#!/usr/bin/env bash
#
# Interactive helper functions/aliases around ownership.

###
# Recursively claim ownership of any files within a path.
# Arguments:
#   $1 - Path to claim ownership to
# Outputs:
#   Nothing or help
# Returns:
#   Result of chown or 1, if help was outputed
###
meownr() {
	if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
		echo "Recursively claim ownership to the current user."
		echo "Usage: meownr <path>"
		echo ""
		return 1
	fi
	if command -v "sudo" >/dev/null 2>&1; then
		sudo chown -R "$(whoami)" $1
	else
		chown -R "$(whoami)" $1
	fi
}

###
# Recursively claim ownership of any files within a path for a specific user/group.
# Arguments:
#   $1 - User and group to give ownership to
#   $2 - Path to claim ownership to
# Outputs:
#   Nothing or help
# Returns:
#   Result of chown or 1, if help was outputed
###
chownr() {
	if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
		echo "Recursively claim ownership of any files within a path for a specific user/group."
		echo "Usage: chownr <user>:<group> <path>"
		echo ""
		return 1
	fi
	if command -v "sudo" >/dev/null 2>&1; then
		sudo chown -R $1 $2
	else
		chown -R $1 $2
	fi
}

