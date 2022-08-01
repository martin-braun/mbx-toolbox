#!/bin/zsh
#
# Essential helper library for zsh terminals.

set -e

# Source init.d shell scripts.
files=( "$(find "$(dirname "$(realpath "${(%):-%N}")")/init.d" -type f -name '*.sh')" )
for f in "${files[@]}"; do
	[[ -f $f ]] && . $f --source-only
done 

set +e
