@ECHO OFF
: 
: Interactive helper functions/aliases around the usage of nvm for Windows.
IF not "%1" == "" SHIFT & GOTO:%1

:::

GOTO:EOF
::: FUNCTIONS :::

:::
: Smart nvm-install that will use the contents of .nvmrc as argument, 
: if the file exists and no argument is given
: Arguments:
:   %1 - Version to use (optional)
: Outputs:
:   nvm output
: Returns:
:   Greater than 1, if the nvm command failed, 0 otherwise
:::
:nvm-use
SET V=%1
IF "%V" == "" (
	IF EXIST ".nvmrc" (
		SET /P V=<.nvmrc
	)
)
nvm install %V
EXIT /B

:::
: Smart nvm-use that will use the contents of .nvmrc as argument, 
: if the file exists and no argument is given
: Arguments:
:   %1 - Version to use (optional)
: Outputs:
:   nvm output
: Returns:
:   Greater than 1, if the nvm command failed, 0 otherwise
:::
:nvm-use
SET V=%1
IF "%V" == "" (
	IF EXIST ".nvmrc" (
		SET /P V=<.nvmrc
	)
)
nvm use %V
EXIT /B

