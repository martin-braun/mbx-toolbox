@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

CALL "%MBX_LIBPATH%\_" load || EXIT /B

SET usage=^
Usage: %~n0 [OPTIONS]!BR!^
Downloads the latest release of Adminer and launches the default PHP server on the system.!BR!^
Adminer allows to edit and inspect local databases of the following kinds:!BR!^
!BR!^
- MySQL!BR!^
- SQLite!BR!^
- PostgreSQL!BR!^
- Oracle!BR!^
- MS SQL!BR!^
- MongoDB!BR!^
- Elasticsearch!BR!^
!BR!^
Requires PHP to be installed to launch a local PHP server.!BR!^
Adminer will be opened in the default browser.!BR!^
!BR!^
OPTIONS!BR!^
  -V,   --version                 Prints the version of this script suite (MBX).!BR!^
  -v,   --verbose                 Prints verbose information.!BR!^
  -h,   --help                    Prints this help message

SET port=7697
:getopts
IF NOT "%1" == "" (
	( ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "-V" ) || ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "--version" ) ) && (
		ECHO %MBX_VERSION%
		EXIT /B 0
	)
	( ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "-v" ) || ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "--verbose" ) ) && (
		SET verbose=1
		SHIFT && GOTO :getopts
	)
	( ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "-p" ) || ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "--port" ) ) && (
		SET port=%2
		SHIFT && SHIFT && GOTO :getopts
	)
	( ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "-h" ) || ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "--help" ) ) && (
		ECHO !usage!
		EXIT /B 0
	)
	ECHO "[x] Invalid command line flag %1" >&2 & EXIT /B 1
)

( CALL "%MBX_LIBPATH%\_" test-if "%verbose%" EQU "1" ) && @ECHO ON

@REM TODO: Implement adminer in Windows (requires test-command)
ECHO "[x] Not implemented ..."

@ECHO OFF & ECHO [o] Done^^! & EXIT /B
