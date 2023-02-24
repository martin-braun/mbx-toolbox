# Essential helper library for shell terminals and scripts.

export MBX_LIBPATH="$MBX_PATH/lib"
export MBX_BINPATH="$MBX_PATH/bin"

# Source init.d shell scripts.
for f in $(find "$MBX_LIBPATH/init.d" -maxdepth 1 -type f -name '*.sh'); do
	\. "$f" || echo "- Failed to source $f" >&2;
done

