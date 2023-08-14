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
DOSKEY gitbr=git rev-parse --abbrev-ref HEAD

:::
: Pulls all branches and rebases the commits on the working changes.
: Arguments:
:   None
: Outputs:
:   Nothing
: Returns:
:   1, if the underlying git command failed, 0 otherwise
:::
DOSKEY gitpb=git pull --rebase

:::
: Attempts to pulls all branches and cancels the action on existing working changes.
: Arguments:
:   None
: Outputs:
:   Nothing
: Returns:
:   1, if the underlying git command failed (i.e. when working changes are available), 0 otherwise
:::
DOSKEY gitpf=git pull --ff-only

:::
: Pushes all branches to the remote.
: Arguments:
:   None
: Outputs:
:   Nothing
: Returns:
:   1, if the underlying git command failed, 0 otherwise
:::
DOSKEY gitpa=git push --all

:::
: Ammends the working changes into the last commit.
: Arguments:
:   None
: Outputs:
:   Nothing
: Returns:
:   1, if the underlying git command failed, 0 otherwise
:::
DOSKEY gita=git commit --amend --no-edit

GOTO:EOF
::: FUNCTIONS :::

:::
: 
: Commits the current working changes using semantic commit messages.
: Arguments:
:   %1 - Semantic scoped verb [ feat | fix | docs | style | refactor | test | chore ][!][@<scope>]?
:   %* - Commit message
: Outputs:
:   Verbose information or error
: Returns:
:   1, if the merge failed, 0 otherwise
:::
:gitco
SET "verb="
SET "scope="
FOR /F "tokens=1-2 delims=@" %%i IN ("%~1") DO (
	SET "verb=%%~i"
	SET "scope=%%~j"
)
IF NOT "%scope%" == "" (
	IF NOT "%verb%" == "%scope%" (
		SET "verb=%verb%(%scope%)"
	)
)
SHIFT
git commit -m "%verb%: %*"
EXIT /B

:::
: Finds all commits of all branches with a given string in the description.
: Arguments:
:   %1 - Fulltext search text for all commits
: Outputs:
:   Verbose information about the result
: Returns:
:   1, if the query failed or nothing was found, 0 otherwise
:::
:gitfind
git log -G"%~1" -p --all
EXIT /B

:::
: Merges the current branch into the given branches.
: Repository must not have working changes active.
: Arguments:
:   %* - Branchnames of the branches to merge into
: Outputs:
:   Verbose information or error
: Returns:
:   1, if the merge failed, 0 otherwise
:::
:gitfuse
FOR /F "tokens=1 delims=*" %%i IN ('git rev-parse --abbrev-ref HEAD') DO @SET "current_branch=%%i"
FOR %%b in ("%*") DO (
	IF not "%%b" == "%current_branch%" (
		git checkout %%~b
		git merge %current_branch%
	)
)
git checkout %current_branch%
EXIT /B

:TODO: Add usage messages to functions.
