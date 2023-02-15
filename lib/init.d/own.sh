# Interactive helper functions/aliases around ownership.

###
# Recursively claim ownership of any files within a path.
# Arguments:
#   $1 - Path to claim file ownership to
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
	if command -v "doas" > /dev/null 2>&1; then
		doas chown -R "$(whoami)" $1
	elif command -v "sudo" > /dev/null 2>&1; then
		sudo chown -R "$(whoami)" $1
	else
		chown -R "$(whoami)" $1
	fi
}

###
# Recursively claim ownership via group of any files within a path.
# Arguments:
#   $1 - Path to claim group ownership to
# Outputs:
#   Nothing or help
# Returns:
#   Result of chown or 1, if help was outputed
###
megrpr() {
	if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
		echo "Recursively claim ownership to the current group."
		echo "Usage: megrpr <path>"
		echo ""
		return 1
	fi
	if command -v "doas" > /dev/null 2>&1; then
		doas chgrp -R "$(id -gn)" $1
	elif command -v "sudo" > /dev/null 2>&1; then
		sudo chgrp -R "$(id -gn)" $1
	else
		chgrp -R "$(id -gn)" $1
	fi
}

###
# Recursively change ownership of any files within a path for a specific user/group.
# Arguments:
#   $1 - User and group to give ownership
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
	if command -v "doas" > /dev/null 2>&1; then
		doas chown -R $1 $2
	elif command -v "sudo" > /dev/null 2>&1; then
		sudo chown -R $1 $2
	else
		chown -R $1 $2
	fi
}

###
# Recursively change ownership via group of any files within a path for a specific user/group.
# Arguments:
#   $1 - Group to give ownership
#   $2 - Path to claim ownership to
# Outputs:
#   Nothing or help
# Returns:
#   Result of chown or 1, if help was outputed
###
chgrpr() {
	if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
		echo "Recursively claim ownership of any files within a path for a specific group."
		echo "Usage: chgrpr <group> <path>"
		echo ""
		return 1
	fi
	if command -v "doas" > /dev/null 2>&1; then
		doas chgrp -R $1 $2
	elif command -v "sudo" > /dev/null 2>&1; then
		sudo chgrp -R $1 $2
	else
		chgrp -R $1 $2
	fi
}

