#!/bin/bash
#
# Essential helper library for bash terminals and scripts.

# Skip when already sourced:
test ! $MBX_LIBPATH || return
export MBX_LIBPATH="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# Source init.d shell scripts.
files=( $(find "$MBX_LIBPATH/init.d" -type f -name '*.sh') )
for f in "${files[@]}"; do
	[[ -f $f ]] && { . $f || echo "[o] Failed to source $f"; }
done 
