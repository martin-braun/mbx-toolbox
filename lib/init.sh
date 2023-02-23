# Essential helper library for shell terminals and scripts.

# Skip when already sourced:
test -n "$MBX_VERSION" && return

export MBX_LIBPATH="$MBX_PATH/lib"
export MBX_BINPATH="$MBX_PATH/bin"

# Source init.d shell scripts.
for f in $(find "$MBX_LIBPATH/init.d" -type f -name '*.sh' -maxdepth 1); do
	\. "$f" || echo "- Failed to source $f" >&2;
done

