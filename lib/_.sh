# Common bash extension library.

# Skip when already sourced:
test $MBX_LIBLOAD_BASE && return
export MBX_LIBLOAD_BASE=1

###
# Test if a command can be executed.
# Arguments:
#   $1 - command to check.
# Outputs:
#   Nothing.
# Returns:
#   0, if the command exists.
###
testcmd() {
	command -v "$1" > /dev/null 2>&1
}

###
# Run a command with elevated privileges.
# Arguments:
#   $@ - command to execute with elevated privileges.
# Outputs:
#   Requests authentication, if necessary, and outputs the output of the executed command.
# Returns:
#   The result if the command or 1001 if no elevated subexecutor was found, although required.
###
erun() {
	if [ "$(id -u)" = "0" ]; then
		$@
	elif testcmd doas; then
		doas "$@"
	elif testcmd sudo; then
		sudo "$@"
	else
		echo "No doas or sudo found." >&2
		return 1001
	fi
}

