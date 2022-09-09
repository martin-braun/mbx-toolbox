@ECHO OFF
: 
: Interactive helper functions/aliases around networking.
IF NOT "%1" == "" SHIFT & GOTO:%1

GOTO:EOF
::: FUNCTIONS :::

:::
: Recursively claim ownership of any files within a path.
: Arguments:
:   %1 - Path to claim ownership to
: Outputs:
:   Nothing or help
: Returns:
:   Result of chown or 1, if help was outputed
:::
:meownr
SETLOCAL ENABLEEXTENSIONS
SET "attr=%~a1"
IF "%attr:~0,1%" == "d" (
	TAKEOWN /F "%~1" /R /D y
) ELSE (
	TAKEOWN /F "%~1"
)
ENDLOCAL & EXIT /B
