@ECHO OFF
: 
: Interactive helper functions/aliases around networking.
IF not "%1" == "" SHIFT & GOTO:%1

:::
: Outputs the primary local IPv4 address.
: Arguments:
:   None
: Outputs:
:   Primary local IPv4 address
: Returns:
:   1, if the every command failed, 0 otherwise
:::
DOSKEY locip=FOR /F "tokens=4 delims= " %%a IN ('route print ^^^| FIND " 0.0.0.0"') DO @ECHO %%a

:::
: Outputs the public IPv4 address. Requires a working internet co^nection.
: Arguments:
:   None
: Outputs:
:   Public IPv4 address
: Returns:
:   1, if the connection failed, 0 otherwise
:::
DOSKEY pubip=curl -4 icanhazip.com

GOTO:EOF
::: FUNCTIONS :::

:::
: Outputs process and connection information (of the given local port).
: Arguments:
:   %1 - Local port number (skip to show all)
: Outputs:
:   Formatted process and connection information
: Returns:
:   1, if the connection failed, 0 otherwise
:::
:locport
FOR /F "usebackq tokens=1,2,3,4,5 delims= " %%a IN (`netstat -ano ^| FIND ":%1"`) DO (
	FOR /F "tokens=* delims= " %%t IN ('TASKLIST /fi "pid eq %%e" ^2^>NUL ^| FIND "%%e"') DO @ECHO %%t    %%a %%b-^>%%c ^(%%d^)
)
EXIT /B

