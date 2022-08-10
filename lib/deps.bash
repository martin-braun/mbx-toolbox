#!/bin/bash
#
# Dependency management library.

# Skip when already sourced:
test ! $MBX_LIBLOAD_DEPS || return
export MBX_LIBLOAD_DEPS=1

. "$MBX_LIBPATH/_ext.bash"

# Determine primary package manager
if test-command apt-get; then
	PKGMGR="apt-get"
elif test-command brew; then
	PKGMGR="brew"
else
	echo "» No supported package manager found."
	exit 1
fi
export PKGMGR
