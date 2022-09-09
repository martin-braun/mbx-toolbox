#!/bin/sh

export MBX_VERSION=$(cat "$MBX_LIBPATH/../VERSION")

###
# Prints the version of this script suite (MBX).
# Arguments:
#   None
# Outputs:
#   MBX TOOLBOX version
# Returns:
#   0
###
alias mbx-version='echo $MBX_VERSION'
