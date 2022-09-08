@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

CALL "%MBX_LIBPATH%\_" load || EXIT /B

SET usage=^
Usage: %~n0 [OPTIONS]!BR!^
Upgrades Martin Braun's eXtensive toolkit.!BR!^
!BR!^
OPTIONS!BR!^
  -V,   --version                 Prints the version of this script suite (MBX).!BR!^
  -v,   --verbose                 Prints verbose information.!BR!^
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
	( ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "-h" ) || ( CALL "%MBX_LIBPATH%\_" test-if "%1" == "--help" ) ) && (
		ECHO !usage!
		EXIT /B 0
	)
	ECHO "[x] Invalid command line flag %1" >&2 & EXIT /B 1
)

( CALL "%MBX_LIBPATH%\_" test-if "%verbose%" EQU "1" ) && @ECHO ON

ECHO "[o] Upgrading MBX toolkit ..."
SET "dir=%MBX_LIBPATH%\.."
git -C "%dir%" reset --hard HEAD || EXIT /B 1
git -C "%dir%" pull --ff-only || EXIT /B 1
git -C "%dir%" fetch --depth 0 || EXIT /B 1

@ECHO OFF & ECHO [o] Done^^! & EXIT /B
