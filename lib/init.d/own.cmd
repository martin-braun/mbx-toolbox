@ECHO OFF
: 
: Interactive helper functions/aliases around networking.
IF not "%1" == "" SHIFT & GOTO:%1

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
SETLOCAL EnableExtensions
SET "attr=%~a1"
IF "%attr:~0,1%" == "d" (
	takeown /F "%~1" /R /D y
) ELSE (
	takeown /F "%~1"
)
ENDLOCAL & EXIT /B

