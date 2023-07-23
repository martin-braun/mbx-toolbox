# Interactive helper functions/aliases around git.

export GIT_SOURCE_DATA="/usr/local/src/git/share"

###
# Outputs the current branch in the current directory.
# Arguments:
#   None
# Outputs:
#   Current local branch name of HEAD
# Returns:
#   1, if the underlying git command failed, 0 otherwise
###
alias gitbranch="git rev-parse --abbrev-ref HEAD"

###
# Pulls all branches and rebases the commits on the working changes.
# Arguments:
#   None
# Outputs:
#   Nothing
# Returns:
#   1, if the underlying git command failed, 0 otherwise
###
alias gitpullr="git pull --rebase"

###
# Attempts to pulls all branches and cancels the action on existing working changes.
# Arguments:
#   None
# Outputs:
#   Nothing
# Returns:
#   1, if the underlying git command failed (i.e. when working changes are available), 0 otherwise
###
alias gitpullf="git pull --ff-only"

###
# Pushes all branches to the remote.
# Arguments:
#   None
# Outputs:
#   Nothing
# Returns:
#   1, if the underlying git command failed, 0 otherwise
###
alias gitpusha="git push --all"

###
# Ammends the working changes into the last commit.
# # Arguments:
#   None
# Outputs:
#   Nothing
# Returns:
#   1, if the underlying git command failed, 0 otherwise
###
alias gitamend="git commit --amend --no-edit"

###
# Finds all commits of all branches with a given string in the description.
# Arguments:
#   $1 - Fulltext search text for all commits
# Outputs:
#   Verbose information about the result
# Returns:
#   1, if the query failed or nothing was found, 0 otherwise
###
gitfind() {
	if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
		echo "Finds all commits of all branches with a given string in the description."
		echo "Usage: gitfind <search>"
		echo ""
		return 1
	fi
	git log -G"$1" -p --all
}

###
# Merges the current branch into the given branch.
# Repository must not have working changes active.
# Arguments:
#   $@ - Branchnames of the branches to merge into
# Outputs:
#   Verbose information or error
# Returns:
#   1, if the merge failed, 0 otherwise
###
gitfuse() {
	if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
		echo "Merges the current branch into the given branch."
		echo "Usage: gitfuse <into_branch...>"
		echo ""
		return 1
	fi
	current_branch="$(git-branch)"
	for branch in "$@"; do
		if [ "$branch" != "$current_branch" ]; then
			git checkout $branch && git merge $current_branch
		fi
	done
	git checkout $current_branch
}

###
# 
# Arguments:
#   $1 - Fulltext search text for all commits
# Outputs:
#   Verbose information about the result
# Returns:
#   1, if the query failed or nothing was found, 0 otherwise
###
gitfind() {
	if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
		echo "Finds all commits of all branches with a given string in the description."
		echo "Usage: gitfind <search>"
		echo ""
		return 1
	fi
	git log -G"$1" -p --all
}

