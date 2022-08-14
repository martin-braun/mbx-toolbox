#!/bin/sh
#
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
alias locip="hostname -I 2>/dev/null || ipconfig getifaddr en0 2>/dev/null"

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