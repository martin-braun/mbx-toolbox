@ECHO OFF
SETLOCAL EnableExtensions
SETLOCAL EnableDelayedExpansion

CALL "%MBX_LIBPATH%\_" load || EXIT /B

SET usage=^
Usage: %~n0 [OPTIONS]!BR!^
Upgrades Martin Braun's eXtensive toolbox.!BR!^
!BR!^
OPTIONS!BR!^
  -V,   --version                 Prints the version of this script suite (MBX).!BR!^
  -v,   --verbose                 Prints verbose information.!BR!^
  -h,   --help                    Prints this help message

:getopts
IF not "%1" == "" (
	( ( CALL "%MBX_LIBPATH%\_" testif "%1" == "-V" ) || ( CALL "%MBX_LIBPATH%\_" testif "%1" == "--version" ) ) && (
		ECHO %MBX_VERSION%
		EXIT /B 0
	)
	( ( CALL "%MBX_LIBPATH%\_" testif "%1" == "-v" ) || ( CALL "%MBX_LIBPATH%\_" testif "%1" == "--verbose" ) ) && (
		SET verbose=1
		SHIFT && GOTO :getopts
	)
	( ( CALL "%MBX_LIBPATH%\_" testif "%1" == "-h" ) || ( CALL "%MBX_LIBPATH%\_" testif "%1" == "--help" ) ) && (
		ECHO !usage!
		EXIT /B 0
	)
	ECHO ! Invalid command line flag %1. >&2 & EXIT /B 1
)

( CALL "%MBX_LIBPATH%\_" testif "%verbose%" == "1" ) && @ECHO ON

ECHO - Upgrading MBX toolbox ...
SET "dir=%MBX_LIBPATH%\.."
git -C "%dir%" fetch || EXIT /B 1
git -C "%dir%" reset --hard "@{u}" || EXIT /B 1

@ECHO OFF & ECHO - Done^^! & EXIT /B
