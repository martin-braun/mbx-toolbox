#!/bin/zsh
#
# Essential helper library for zsh terminals.

# Skip when already sourced:
test ! $MBX_LIBPATH || return
export MBX_LIBPATH="$(dirname "$(realpath "${(%):-%N}")")"

# Source init.d shell scripts.
files=( $(find "$MBX_LIBPATH/init.d" -type f -name '*.sh') )
for f in "${files[@]}"; do
	[[ -f $f ]] && { . $f || echo "» Failed to source $f"; }
done 
