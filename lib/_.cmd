@ECHO OFF
SETLOCAL EnableExtensions
SHIFT & GOTO:%1
: Common batch extension library.

:load
: Skip when already called:
IF defined MBX_LIBLOAD_BASE (
	EXIT /B
)
ENDLOCAL
SET "MBX_LIBLOAD_BASE=1"
SET BR=^


@REM The above 2 empty lines are required for the batch file to work.
EXIT /B

:::
: Sets a variable to the output of a command substitution.
: Arguments:
:   %1 - Variable name of the variable that the output of the function will be written into.
:   %2 - Double-quoted command that should be executed, whose output will be piped into the variable.
:        Can contain additional quotes, the outer quotes will be replaced with backticks.
:        Must not contain backticks.
:   %3 - /F for slower file mode to return a correct errorlevel.
: Outputs:
:   Nothing.
: Returns:
:   0, if the command was successful or if the file mode is disabled, 1 otherwise.
:::
:subset
IF not "%3" == "/F" (
	IF not "%3" == "/f" (
		FOR /F "usebackq tokens=*" %%a IN (`%~2`) DO (
			ENDLOCAL & SET "%~1=%%a"
		)
		EXIT
		@REM ERRORLEVEL will only be other than 0 if the FOR statement failed, not the command itself.
	)
)
SET "tempfile=%temp%\%~n0.%random%"
%~2>"%tempfile%"
ENDLOCAL & SET /P %~1=<"%tempfile%" & DEL /Q "%tempfile%" & EXIT /B %ERRORLEVEL%

:::
: Performs conditional processing in batch programs. Is callable for inline use.
: Arguments:
:   %1 - /I for case-insensitive comparison on strings, can be skipped for case-sensitive comparison.
:   %2 - NOT to negate the result, can be skipped.
:   %3 - EXIST for file checks or first string to compare with, also supports "string1"=="string2" (full condition).
:   %4 - If EXIST is specified, path to the directory or file. 
:        Otherwise if %3 is not a full condition, this argument has to be one of:
:        - ==   Compares both strings to be equal using lstrcmpW or lstrcmpiW (case-insensitive).
:        - EQU  Converts both strings to numbers and checks if they are equal. 
:        - NEQ  Converts both strings to numbers and checks if they are not equal.
:        - LSS  Converts both strings to numbers and checks if the first is lesser than the second.
:        - LEQ  Converts both strings to numbers and checks if the first is lesser or equal than the second.
:        - GTR  Converts both strings to numbers and checks if the first is greater than the second.
:        - GEQ  Converts both strings to numbers and checks if the first is greater or equal than the second.
:        If a string cannot be parsed to a number, its numeric representation will be used. 
:        This argument can be skipped, so == will be used.
:   %5 - If %3 is not a full condition, this argument has to be the second string to compare.
: Outputs:
:   Nothing.
: Returns:
:   0, if the condition is met, 1 otherwise.
:::
:testif
IF "%~1"=="/I" SET "I=/I " & SHIFT
IF "%~1"=="/i" SET "I=/I " & SHIFT
IF "%~1"=="NOT" SET "NOT=not " & SHIFT
IF "%~1"=="not" SET "NOT=not " & SHIFT
IF "%~1"=="EXIST" SET "EXIST=exist " & SHIFT
IF "%~1"=="exist" SET "EXIST=exist " & SHIFT

SET "string1=%~1%"
IF "%~3"=="" (
	SET "comp=^=^="
	SET "string2=%~2"
) ELSE (
	SET "comp=%~2"
	SET "string2=%~3"
)
IF %I%%NOT%%EXIST% "%string1%" %comp% "%string2%" (
	ENDLOCAL & EXIT /B 0
)
ENDLOCAL & EXIT /B 1

:::
: Test if a command can be executed. Do not pass additional arguments.
: Arguments:
:   %1 - command to check.
: Outputs:
:   Nothing
: Returns:
:   0, if the command exists, 1 otherwise.
:::
:testcmd
where %~1 1>NUL 2>NUL
ENDLOCAL & EXIT /B

