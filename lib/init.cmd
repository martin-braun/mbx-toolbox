@ECHO OFF
: 
: Essential helper library for batch terminals.

: Skip when already called:
IF NOT "%MBX_VERSION%" == "" DO EXIT /B

SET "MBX_LIBPATH=%MBX_PATH%\lib"
SET "MBX_BINPATH=%MBX_PATH%\bin"

: Call init.d cmd scripts.
FOR %%f IN ( "%MBX_LIBPATH%\init.d\*.cmd" ) DO ( 
	@REM ECHO %%f
	CALL "%%f"
)

