#!/usr/bin/env bash
#
# Common bash extension library.

# Skip when already sourced:
test ! $MBX_LIBLOAD_BASE || return
export MBX_LIBLOAD_BASE=1

###
# Test if a command can be executed.
# Arguments:
#   $1 - command to check.
# Outputs:
#   Nothing.
# Returns:
#   0, if the command exists.
###
test-command() {
command -v "$1" &>/dev/null
}

###
# Ensure packages are installed using the default package manager and re-source rc.
# Arguments:
#   $@ - packages to install if not installed
# Outputs:
#   Installer log or function error, otherwise nothing.
# Returns:
#   0, if packages were found or were installed successfully, otherwise the last error of the package manager. 
#   Also returns 1, if the existence of the package could not be verified or no matching package manager was found to install a package.
#   Returns 1001, if the dot-rc of the current shell could not be reload.
###
ensure-installed() {
if test-command dpkg; then
	for pkg in "$@"; do
		if ! dpkg -l "$pkg" | grep -q ^ii; then
			if test-command apt-get; then
				apt-get install $pkg -y
			else
				echo "Unable to ensure $pkg, because no package manager to install the package was found."
				return 1
			fi
			inst=1
		fi
	done
elif test-command rpm; then
	for pkg in "$@"; do
		if ! rpm --nosignature --nodigest -q "$pkg" &>/dev/null; then
			if test-command dnf; then
				dnf install $pkg -y
			elif test-command yum; then
				yum install $pkg -y
			else
				echo "Unable to ensure $pkg, because no package manager to install the package was found."
				return 1
			fi
			inst=1
		fi
	done
elif test-command brew; then
	for pkg in "$@"; do
		if ! brew list $pkg &>/dev/null; then
			brew install $pkg -y
			inst=1
		fi
	done
else
	echo "Unable to ensure $@, because no package detection was found."
	return 1
fi
[ $inst ] || return
rc="$HOME/.${SHELL##*/}rc"
[ -f "$rc" ] || return 1001
\. "$rc"
}

