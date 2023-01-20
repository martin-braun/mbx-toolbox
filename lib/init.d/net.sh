# Interactive helper functions/aliases around networking.

###
# Outputs the primary local IPv4 address.
# Arguments:
#   None
# Outputs:
#   Primary local IPv4 address
# Returns:
#   1, if the every command failed, 0 otherwise
###
alias locip="hostname -I 2>/dev/null || osascript -e 'IPv4 address of (system info)'"

###
# Outputs the public IPv4 address. Requires a working internet connection.
# Arguments:
#   None
# Outputs:
#   Public IPv4 address
# Returns:
#   1, if the connection failed, 0 otherwise
###
alias pubip="curl -4 icanhazip.com"

###
# Outputs process and connection information (of the given local port).
# Arguments:
#   $1 - Local port number (skip to show all)
# Outputs:
#   Formatted process and connection information
# Returns:
#   1, if the connection failed, 0 otherwise
###
locport() {
	if [ -z $1 ]; then
		lsof -P -i
	else
		lsof -P -i:$1
	fi
}

