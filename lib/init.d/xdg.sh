#!/usr/bin/env sh
#
# Interactive Cross-Desktop Group variables.

export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
mkdir -p "$XDG_DATA_HOME"
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
mkdir -p "$XDG_CONFIG_HOME"
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}
mkdir -p "$XDG_STATE_HOME"
export XDG_DATA_DIRS=${XDG_DATA_DIRS:="/usr/local/share:/usr/share"}
export XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS:="/etc/xdg"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
mkdir -p "$XDG_CACHE_HOME"
if [ -z "$XDG_RUNTIME_DIR" ]; then
	uid="$(id -u)"
	if [ -d "/run/user/$uid" ]; then
		export XDG_RUNTIME_DIR="/run/user/$uid"
	else
		tmpdir="$TMPDIR"
		test -n "$tmpdir" || tmpdir="/tmp"
		XDG_RUNTIME_DIR="$tmpdir/runtime-$uid"
		if ! [ -d "$XDG_RUNTIME_DIR" ]; then
			mkdir -p "$XDG_RUNTIME_DIR"
			chmod 0700 "$XDG_RUNTIME_DIR"
		fi
	fi
fi

