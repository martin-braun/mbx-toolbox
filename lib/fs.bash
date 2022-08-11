#!/bin/bash
#
# File system library.

# Skip when already sourced:
test ! $MBX_LIBLOAD_FS || return
export MBX_LIBLOAD_FS=1

. "$MBX_LIBPATH/_.bash"

# t.b.d.
