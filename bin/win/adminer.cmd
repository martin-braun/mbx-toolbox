@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

CALL "%MBX_LIBPATH%\_" load || EXIT /B

SET usage=^
Usage: %~n0 [OPTIONS]!BR!^
Downloads the latest release of Adminer and launches it with the default PHP server on the system.!BR!^
Adminer allows to edit and inspect local databases of the following types:!BR!^
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
  -p=*, --port=*                  Defines the local port that should be used to serve Adminer.!BR!^
  -h,   --help                    Prints this help message

SET port=7697
:getopts
IF NOT "%1" == "" (
	( ( CALL "%MBX_LIBPATH%\_" testif "%1" == "-V" ) || ( CALL "%MBX_LIBPATH%\_" testif "%1" == "--version" ) ) && (
		ECHO %MBX_VERSION%
		EXIT /B 0
	)
	( ( CALL "%MBX_LIBPATH%\_" testif "%1" == "-v" ) || ( CALL "%MBX_LIBPATH%\_" testif "%1" == "--verbose" ) ) && (
		SET verbose=1
		SHIFT && GOTO :getopts
	)
	( ( CALL "%MBX_LIBPATH%\_" testif "%1" == "-p" ) || ( CALL "%MBX_LIBPATH%\_" testif "%1" == "--port" ) ) && (
		SET port=%2
		SHIFT && SHIFT && GOTO :getopts
	)
	( ( CALL "%MBX_LIBPATH%\_" testif "%1" == "-h" ) || ( CALL "%MBX_LIBPATH%\_" testif "%1" == "--help" ) ) && (
		ECHO !usage!
		EXIT /B 0
	)
	ECHO [x] Invalid command line flag %1. >&2 & EXIT /B 1
)

( CALL "%MBX_LIBPATH%\_" testif "%verbose%" EQU "1" ) && @ECHO ON

( CALL "%MBX_LIBPATH%\_" testc php ) || (
	ECHO [x] PHP missing ...
	EXIT /B 1
)

SET "tempfile=%temp%\%~n0.%random%"
SET "adminer_repo=https://github.com/vrana/adminer"
FOR /F "usebackq tokens=3 delims=/" %%a IN (`git ls-remote --tags "%adminer_repo%"`) DO (
	SET "adminer_tag=%%a"
)
curl -L %adminer_repo%/releases/download/%adminer_tag%/adminer-%adminer_tag:~1%-en.php >"%tempfile%"
SET "adminer_host=0.0.0.0"
SET "adminer_domain=localhost:%port%"
START "" "http://%adminer_domain%"
ECHO [i] Starting local server, CTRL+C to stop and remove traces.
php -S "%adminer_host%:%port%" "%tempfile%"
DEL /S "%tempfile%" >NUL 2>&1

@ECHO OFF & ECHO [o] Done^^! & EXIT /B
