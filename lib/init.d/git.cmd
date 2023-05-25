@ECHO OFF
: 
: Interactive helper functions/aliases around git.
IF not "%1" == "" SHIFT & GOTO:%1

:::
: Outputs the current branch in the current directory.
: Arguments:
:   None
: Outputs:
:   Current local branch name of HEAD
: Returns:
:   1, if the underlying git command failed, 0 otherwise
:::
DOSKEY git-branch=git rev-parse --abbrev-ref HEAD

:::
: Pulls all branches and rebases the commits on the working changes.
: Arguments:
:   None
: Outputs:
:   Nothing
: Returns:
:   1, if the underlying git command failed, 0 otherwise
:::
DOSKEY git-pullr=git pull --rebase

:::
: Attempts to pulls all branches and cancels the action on existing working changes.
: Arguments:
:   None
: Outputs:
:   Nothing
: Returns:
:   1, if the underlying git command failed (i.e. when working changes are available), 0 otherwise
:::
DOSKEY git-pullf=git pull --ff-only

:::
: Pushes all branches to the remote.
: Arguments:
:   None
: Outputs:
:   Nothing
: Returns:
:   1, if the underlying git command failed, 0 otherwise
:::
DOSKEY git-pusha=git push --all

GOTO:EOF
::: FUNCTIONS :::

:::
: Finds all commits of all branches with a given string in the description.
: Arguments:
:   %1 - Fulltext search text for all commits
: Outputs:
:   Verbose information about the result
: Returns:
:   1, if the query failed or nothing was found, 0 otherwise
:::
:gitlog
git log -G"%~1" -p --all
EXIT /B

:::
: Merges the current branch into the given branch.
: Repository must not have working changes active.
: Arguments:
:   %1 - Branchname of the branch to merge into
: Outputs:
:   Verbose information or e~ror
: Returns:
:   1, if the merge failed, 0 otherwise
:::
:gitfuse
FOR /F "tokens=4 delims=*" %%i IN ('git-branch') DO @SET "branch=%%i"
git checkout %1 && git merge %branch% && git checkout %branch%
EXIT /B

