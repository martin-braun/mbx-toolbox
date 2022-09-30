#!/bin/bash
#
# Essential helper library for bash terminals and scripts.

# Skip when already sourced:
command -v "mbx-version" >/dev/null 2>&1 && return 1

export MBX_LIBPATH="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
export MBX_BINPATH="$MBX_LIBPATH/../bin"

# Source init.d shell scripts.
files=( $(find "$MBX_LIBPATH/init.d" -type f -name '*.sh') )
for f in "${files[@]}"; do
	# echo $f
	[[ -f $f ]] && { . $f || echo "[o] Failed to source $f"; }
done 
