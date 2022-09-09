#!/bin/sh
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
