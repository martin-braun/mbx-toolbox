#!/usr/bin/env bash
#
# Interactive helper functions/aliases around git.

###
# Outputs the current branch in the current directory.
# Arguments:
#   None
# Outputs:
#   Current local branch name of HEAD
# Returns:
#   1, if the underlying git command failed, 0 otherwise
###
alias git-branch="git rev-parse --abbrev-ref HEAD"

###
# Pulls all branches and rebases the commits on the working changes.
# Arguments:
#   None
# Outputs:
#   Nothing
# Returns:
#   1, if the underlying git command failed, 0 otherwise
###
alias git-pullr="git pull --rebase"

###
# Attempts to pulls all branches and cancels the action on existing working changes.
# Arguments:
#   None
# Outputs:
#   Nothing
# Returns:
#   1, if the underlying git command failed (i.e. when working changes are available), 0 otherwise
###
alias git-pullf="git pull --ff-only"

###
# Pushes all branches to the remote.
# Arguments:
#   None
# Outputs:
#   Nothing
# Returns:
#   1, if the underlying git command failed, 0 otherwise
###
alias git-pusha="git push --all"

###
# Finds all commits of all branches with a given string in the description.
# Arguments:
#   $1 - Fulltext search text for all commits
# Outputs:
#   Verbose information about the result
# Returns:
#   1, if the query failed or nothing was found, 0 otherwise
###
git-search() {
	git log -G"$1" -p --all
}

###
# Merges the current branch into the given branch.
# Repository must not have working changes active.
# Arguments:
#   $1 - Branchname of the branch to merge into
# Outputs:
#   Verbose information or error
# Returns:
#   1, if the merge failed, 0 otherwise
###
git-merge-to() {
	branch="$(git-branch)"
	git checkout $1 && git merge $branch && git checkout $branch
}
