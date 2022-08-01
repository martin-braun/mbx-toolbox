#!/bin/bash
#
# Essential helper library for bash terminals and scripts.

set -e

# Source init.d shell scripts.
files=( "$(find "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/init.d" -type f -name '*.sh')" )
for f in "${files[@]}"; do
	[[ -f $f ]] && . $f --source-only
done 

set +e
