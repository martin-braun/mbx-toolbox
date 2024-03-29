@ECHO OFF
: 
: Interactive Cross-Desktop Group variables.
IF not "%1" == "" SHIFT & GOTO:%1

IF NOT EXIST "%USERPROFILE%\.local" MKLINK /D "%USERPROFILE%\.local" "%LOCALAPPDATA%"
IF "%XDG_DATA_HOME%" == "" SET "XDG_DATA_HOME=%LOCALAPPDATA%\share"
IF NOT EXIST "%XDG_DATA_HOME%" MKDIR "%XDG_DATA_HOME%" 
IF "%XDG_STATE_HOME%" == "" SET "XDG_STATE_HOME=%LOCALAPPDATA%\state"
IF NOT EXIST "%XDG_STATE_HOME%" MKDIR "%XDG_STATE_HOME%" 
IF NOT EXIST "%USERPROFILE%\.config" MKLINK /D "%USERPROFILE%\.config" "%APPDATA%"
IF "%XDG_CONFIG_HOME%" == "" SET "XDG_CONFIG_HOME=%APPDATA%"
IF NOT EXIST "%USERPROFILE%\.cache" MKLINK /D "%USERPROFILE%\.cache" "%LOCALAPPDATA%\Temp"
IF "%XDG_CACHE_HOME%" == "" SET "XDG_CACHE_HOME=%LOCALAPPDATA%\Temp"
IF "%XDG_DATA_DIRS%" == "" SET "XDG_DATA_DIRS=%PROGRAMDATA%"
IF "%XDG_CONFIG_DIRS%" == "" SET "XDG_CONFIG_DIRS=%PROGRAMDATA%\xdg"
IF "%XDG_RUNTIME_DIR%" == "" SET "XDG_RUNTIME_DIR=%TEMP%/runtime-%USERSID%"
IF NOT EXIST "%XDG_RUNTIME_DIR%" MKDIR "%XDG_RUNTIME_DIR%" 

