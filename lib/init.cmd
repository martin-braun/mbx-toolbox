@ECHO OFF
: 
: Essential helper library for batch terminals.

: Skip when already called:
mbx-version 1>NUL 2>NUL
IF NOT %ERRORLEVEL% == 0 DO EXIT /B

SET "MBX_LIBPATH=%~dp0."

: Call init.d cmd scripts.
FOR %%f IN ( "%MBX_LIBPATH%\init.d\*.cmd" ) DO ( 
	@REM ECHO %%f
	CALL "%%f"
)

DOSKEY mbx-version=ECHO ^%MBX_VERSION%
