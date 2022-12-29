#!/usr/bin/env bash
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
	if [ -d "/run/user/$UID" ]; then
		export XDG_RUNTIME_DIR="/run/user/$UID"
	else
		export XDG_RUNTIME_DIR=$(ls -d ${TMPDIR}runtime-$UID 2>/dev/null || mktemp -d ${TMPDIR}runtime-$UID | tee >(xargs chmod 0700))
	fi
fi

