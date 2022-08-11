@ECHO OFF
: 
: Essential helper library for batch terminals.

: Skip when already called:
IF DEFINED MBX_LIBPATH (
	EXIT /B
) ELSE (
	SET "MBX_LIBPATH=%~dp0."
)

: Call init.d cmd scripts.
FOR %%f IN ( "%MBX_LIBPATH%\init.d\*.cmd" ) DO ( 
	CALL "%%f"
)
