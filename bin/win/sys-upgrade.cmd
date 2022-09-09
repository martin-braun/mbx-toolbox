@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

CALL "%MBX_LIBPATH%\_" load || EXIT /B

SET usage=^
Usage: %~n0 [OPTIONS]!BR!^
Upgrades all packages of all supported package managers. Supports:!BR!^
!BR!^
- choco!BR!^
- gem!BR!^
!BR!^
OPTIONS!BR!^
  -V,   --version                 Prints the version of this script suite (MBX).!BR!^
  -v,   --verbose                 Prints verbose information.!BR!^
  -r,   --reboot                  Reboots the system after successful upgrade.!BR!^
  -h,   --help                    Prints this help message

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
	( ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "-r" ) || ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "--reboot" ) ) && (
		SET reboot=1
		SHIFT && GOTO :getopts
	)
	( ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "-h" ) || ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "--help" ) ) && (
		ECHO !usage!
		EXIT /B 0
	)
	ECHO [x] Invalid command line flag %1. >&2 & EXIT /B 1
)

( CALL "%MBX_LIBPATH%\_" test-if "%verbose%" == "1" ) && @ECHO ON

NET SESSION >NUL 2>&1
IF NOT "%ERRORLEVEL%" == "0" (
	ECHO [x] Please run this script in an elevated command shell. >&2 & EXIT /B 1
)

( CALL "%MBX_LIBPATH%\_" test-command choco ) && (
	ECHO [o] Upgrading Chocolatey packages ...
	choco upgrade chocolatey -y --accept-license || EXIT /B 1
	choco upgrade all -y --accept-license || EXIT /B 1
)

( CALL "%MBX_LIBPATH%\_" test-command gem ) && (
	ECHO [o] Upgrading Ruby gems ...
	gem update --system || EXIT /B 1
)

IF "%reboot%" == "1" (
	SHUTDOWN /R /T 0
)

@ECHO OFF & ECHO [o] Done^^! & EXIT /B
