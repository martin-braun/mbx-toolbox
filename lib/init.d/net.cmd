: 
: 
: Interactive helper functions/aliases around networking.

:::
: Outputs the primary local IPv4 address.
: Arguments:
:   None
: Outputs:
:   Primary local IPv4 address
: Returns:
:   1, if the every command failed, 0 otherwise
:::
DOSKEY locip=FOR /F "tokens=4 delims= " %%i in ('route print ^^^| FIND " 0.0.0.0"') DO @ECHO %%i

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