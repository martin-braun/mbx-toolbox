@ECHO OFF

SET /P MBX_VERSION=<"%MBX_LIBPATH%\\..\\VERSION"

:::
: Prints the version of this script suite (MBX).
: Arguments:
:   None
: Outputs:
:   MBX TOOLBOX version
: Returns:
:   0
:::
DOSKEY mbx-version=ECHO ^%MBX_VERSION%

