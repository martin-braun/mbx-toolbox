MBX TOOLBOX
===========

Martin Braun's eXtensive toolbox

Bash/Batch helper libraries/aliases/functions for Windows, MacOS and Debian (based) and Red Hat (based) distributions.

Table of Contents
-----------------

- [MBX TOOLBOX](#mbx-toolbox)
	- [Table of Contents](#table-of-contents)
	- [Disclaimer](#disclaimer)
	- [Commands](#commands)
		- [Aliases / DOSKEYs](#aliases--doskeys)
		- [Aliases / DOSKEYs](#aliases--doskeys)
		- [Interactive Functions](#interactive-functions)
		- [Helper Functions](#helper-functions)
		- [Scripts](#scripts)
	- [Installation](#installation)
		- [Debian (incl. Proxmox)](#debian-incl-proxmox)
		- [Red Hat (incl. Fedora / Nobara)](#red-hat-incl-fedora-nobara)
		- [MacOS](#macos)
		- [Windows](#windows)
		- [Final steps](#final-steps)
	- [Update](#update)
	- [Uninstall](#uninstall)
		- [\*nix (Debian / MacOS / etc.)](#nix-debian--macos--etc)
		- [Windows](#windows-1)
	- [Contribute](#contribute)

Disclaimer
----------

Use at your own risk. I will not be responsible for any damages that might occur whilst using my toolbox.

Commands
--------

### Variables

> Helper variables are defined when launching an interactive shell and will also be available in your scripts.

|Library|Variable|Platforms|Description|
|-|-|-|-|
|`xdg`|`XDG_DATA_HOME`|`all`|Environment variable of the XDG Base Directory Specification. If the variable was already set, it will be unchanged, otherwise it will default to the recommend value of the specification which is `$HOME/.local/share` on POSIX systems and `` (unofficial) on Windows systems.|
|`xdg`|`XDG_CONFIG_HOME`|`all`|Environment variable of the XDG Base Directory Specification. If the variable was already set, it will be unchanged, otherwise it will default to the recommend value of the specification which is `$HOME/.config` on POSIX systems and `` (unofficial) on Windows systems.|
|`xdg`|`XDG_STATE_HOME`|`all`|Environment variable of the XDG Base Directory Specification. If the variable was already set, it will be unchanged, otherwise it will default to the recommend value of the specification which is `$HOME/.local/state` on POSIX systems and `` (unofficial) on Windows systems.|
|`xdg`|`XDG_DATA_DIRS`|`all`|Environment variable of the XDG Base Directory Specification. If the variable was already set, it will be unchanged, otherwise it will default to the recommend value of the specification which is `/usr/local/share/:/usr/share/` on POSIX systems and `` (unofficial) on Windows systems.|
|`xdg`|`XDG_CONFIG_DIRS`|`all`|Environment variable of the XDG Base Directory Specification. If the variable was already set, it will be unchanged, otherwise it will default to the recommend value of the specification which is `/etc/xdg` on POSIX systems and `` (unofficial) on Windows systems.|
|`xdg`|`XDG_CACHE_HOME`|`all`|Environment variable of the XDG Base Directory Specification. If the variable was already set, it will be unchanged, otherwise it will default to the recommend value of the specification which is `$HOME/.cache` on POSIX systems and `` (unofficial) on Windows systems.|
|`xdg`|`XDG_RUNTIME_DIR`|`all`|Environment variable of the XDG Base Directory Specification. If the variable was already set, it will be unchanged, otherwise it will default to the recommend value of the specification which is `/run/user/$UID` or `${TMPDIR}runtime-$UID` (unofficial) on POSIX systems and `%TEMP%/runtime-%USERSID%` (unofficial) on Windows systems.|

> Please head to the [Environment Variables section in the XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html#variables) to learn more about `XDG` variables and their meaning. Colon separators are replaced with semicolon separators on Windows systems.

### Aliases / DOSKEYs

> Aliases / DOSKEYs are only available in an interactive shell, thus they cannot be used in scripts. They do not allow to pass arguments to them.

|Command|Platforms|Description|
|-|-|-|
|`mbx-version`|`all`|Prints the version of this script suite. (MBX)|
|`locip`|`all`|Outputs the primary local IPv4 address.|
|`pubip`|`all`|Outputs the public IPv4 address. Requires a working internet connection.|
|`git-branch`|`all`|Outputs the current branch in the current directory.|
|`git-pullr`|`all`|Pulls all branches and rebases the commits on the working changes|
|`git-pullf`|`all`|Attempts to pull all branches and cancels the action on existing working changes.|
|`git-pusha`|`all`|Pushes all branches to the remote.|

### Interactive Functions

> Interactive functions will be load on any interactive shell automatically. While they could be called from a script, this is not supported. Their purpose is to run exclusively interactive. A reason for that decision is that the output of such functions is often inconsistent (between platforms) and its use is trivial. Treat those functions like aliases / DOSKEYs with argument support.

|Command|Platforms|Description|
|-|-|-|
|`locport [ port ]`|`all`|Outputs process and connection information (of the given local port).|
|`git-search <text>`|`all`|Finds all commits of all branches with a given string in the description.|
|`git-merge-to <branch>`|`all`|Merges the current branch into the given branch. Repository must not have working changes active.|
|`meownr <path>`|`all`|Recursively claim ownership of any files and folders within and of a path.|
|`chownr <user>:<group> <path>`|`all`|Recursively claim ownership of any files and folders within and of a path to a specific user/group.|

### Helper Functions

> Helper functions can be called in your scripts and cannot be used in interactive shells. To call a helper function in your script use this while replacing `{LIBRARY}` with the library name and `{COMMAND}` with the function name and arguments: 
> 
> Bash: `. "$MBX_LIBPATH/{LIBRARY}.bash" || exit 1` in the header of your bash script, and then simply run `{COMMAND}` (you can use `if` to make conditions based on the return value, i.e. `if test-command php; then; echo "PHP found"; fi`).
> 
> Batch: `CALL "%MBX_LIBPATH%\{LIBRARY}" load || EXIT /B` in the header of your batch script, and then run `CALL "%MBX_LIBPATH%\{LIBRARY}" {COMMAND}` (you can wrap these to make conditions based on the return value, i.e. `( CALL "%MBX_LIBPATH%\_" test-command php ) && ECHO PHP found`).

|Library|Command|Platforms|Description|
|-|-|-|-|
|`_`|`subset <variableName> "<command>" [ /F ]`|`win`|Sets a variable to the output of a command substitution. (`/F` for slower file mode to return a correct errorlevel)|
|`_`|`test-if [ /I ] [ NOT ] [ EXISTS ] <string1> [ == \| EQU \| NEQ \| LSS \| LEQ \| GTR \| GEQ ] <string2>`|`win`|Performs conditional processing in batch programs. Is callable for inline use.|
|`_`|`test-command <command>`|`all`|Ensure a command can be executed. Do not pass additional arguments.|
|`tt`|`to-lower <string>`|`deb`,`rh`,`mac`|Transforms the given text into the lowercase format.|
|`tt`|`to-upper <string>`|`deb`,`rh`,`mac`|Transforms the given text into the uppercase format.|

### Scripts

> Scripts can be called from an interactive shell or they can be used from within any script. They are available in the `PATH` variable and function as full-fledged programs. Every script supports the `-h` flag to print out more help.

|Command|Platforms|Description|
|-|-|-|
|`mbx-upgrade [ -V \| -v \| -h ]`|`all`|Upgrades Martin Braun's eXtensive toolbox.|
|`sys-upgrade [ -V \| -v \| -r \| -h`|`all`|Upgrades all packages of all supported package managers. (`-r` reboots the system after successful upgrade.)|
|`sys-backup [ -V \| -v \| -p=* \| -m=* \| -k \| -l \| -s \| -h ]`|`deb`,`rh`,`mac`|Backups all files given a certain maximum size from the root directory of this system. On MacOS it launches Time Maschine backup instead. (`-p=*` sets the path to the backup directory if possible (default: `$HOME/.sys-backup`).; `-m=*` sets the maximum size of every backup-ed file (default: `10M`).; `-k` keeps the old backup files that are not overwritten. Ignored on MacOS.; `-l` locks the backup by rejecting access permissions to the current user. Ignored on MacOS.; `-s` shutdowns the system 5 minutes after successful system backup.)|
|`chmodr [ -V \| -v \| -d=* \| -f=* \| -c \| -h ]`|`deb`,`rh`,`mac`|Recursively changes modes on directories and files individually. (`-d=*` sets the directory permissions.; `-f=*` sets the file permissions.; `-c` claims ownership of the directories and files.)|
|`adminer [ -V \| -v \| -p=* \| -h ]`|`all`|Downloads the latest release of Adminer and launches it with the default PHP server on the system. (`-p=*` defines the local port that should be used to serve Adminer.)|

Installation
------------

### Debian (incl. Proxmox)

For Debian-based distros simply run the following commands to install essential dependencies and the toolbox. You can run these commands as root, skip sudo in such case: 

```bash
sudo apt update && apt install git -y # don't use sudo if you are root
sudo mkdir -p /usr/local/mbx # don't use sudo if you are root
sudo chown "$(whoami)" /usr/local/mbx # skip, if you are root
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git /usr/local/mbx
echo 'export PATH=$PATH:/usr/local/mbx/bin/deb:/usr/local/mbx/bin' >> $HOME/.bashrc
echo "test -e /usr/local/mbx/lib/init.bash && . /usr/local/mbx/lib/init.bash" >> $HOME/.bashrc
source $HOME/.bashrc
```

### Red Hat (incl. Fedora / Nobara)

For Red Hat-based distros simply run the following commands to install essential dependencies and the toolbox. You can run these commands as root, skip sudo in such case: 

```bash
sudo dnf install git --refresh -y # don't use sudo if you are root
sudo mkdir -p /usr/local/mbx # don't use sudo if you are root
sudo chown "$(whoami)" /usr/local/mbx # skip, if you are root
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git /usr/local/mbx
echo 'export PATH=$PATH:/usr/local/mbx/bin/rh:/usr/local/mbx/bin' >> $HOME/.bashrc
echo "test -e /usr/local/mbx/lib/init.bash && . /usr/local/mbx/lib/init.bash" >> $HOME/.bashrc
source $HOME/.bashrc
```

### MacOS

For MacOS, you should install Homebrew and use it to install a few essential dependencies to use this toolbox. Skip the fist command if Homebrew is already installed:

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git coreutils
sudo mkdir -p /usr/local/mbx
sudo chown "$(whoami)" /usr/local/mbx
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git /usr/local/mbx
echo 'export PATH=$PATH:/usr/local/mbx/bin/mac:/usr/local/mbx/bin' >> $HOME/.zshrc
echo "test -e /usr/local/mbx/lib/init.zsh && . /usr/local/mbx/lib/init.zsh" >> $HOME/.zshrc
source $HOME/.zshrc
```

### Windows

For Windows, you should install Chocolatey and use it to install a few essential dependencies to use this toolbox. For this run the following commands within a privileged command-line terminal (not PowerShell), skip the first command if Chocolatey is already installed:

```bat
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%PROGRAMDATA%\chocolatey\bin"
choco install git awk -y
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d @^%USERPROFILE^%\autorun.cmd" "2^>NUL /f
```

The last command will ensure that an autorun.cmd is sourced in a similar fashion like .bashrc on Linux. This is to enable alias support (DOSKEY) in your interactive shell.

Then, within unprivileged command-line terminal (not PowerShell) run the following commands to install this toolbox and autoload its DOSKEY entries via autorun.cmd:

```bat
MKDIR %PROGRAMDATA%\mbx
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git %PROGRAMDATA%\mbx
SETX PATH "%PATH%;%PROGRAMDATA%\mbx\bin\win;%PROGRAMDATA%\mbx\bin"
ECHO @CALL %PROGRAMDATA%\mbx\lib\init.cmd>>"%USERPROFILE%\autorun.cmd"
```

### Final steps

To validate your installation, restart your terminal and run `mbx-version`. It should print out the [current version](VERSION) to the console.

### Switching to the [dev] branch

If you want to test the latest changes, you can switch to the `dev` branch, but things might break. 

After installation run this in the MBX toolbox path (`/usr/local/mbx` or `%PROGRAMDATA%\mbx`):

```
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch --all
git checkout dev
mbx-upgrade
```

Update
------

Straightforward:

```sh
mbx-update
```
		
Uninstall
---------

### \*nix (Debian / Red Hat / MacOS / etc.)

```sh
rm -r /usr/local/mbx
```

Also remove the lines you added to your .bashrc/.zshrc during installation process.

### Windows

```cmd
DEL /S %PROGRAMDATA%\mbx
rundll32 sysdm.cpl,EditEnvironmentVariables
```

Now remove the paths `%PROGRAMDATA%\mbx\bin\win` and `%PROGRAMDATA%\mbx\bin` from your `%PATH%` variable. Also remove the added lines in `%USERPROFILE%\autorun.cmd`.

If you don't like to keep the auto-loader of the `autorun.cmd`, just remove the file and finalize your purge in an elevated shell with: 

```bat
REG REMOVE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun
```

Contribute
----------

Feel free to open an issue or even expand this toolkit:

- Simple functions or aliases that should be only available in an interactive shell need to be put in [lib/init.d](lib/init.d) and should always use the `#!/bin/sh` shebang and the `.sh` file extension to be imported with maximum compatibility in \*nix scripts, Windows scripts should always end up with `.cmd` and should work without `ENABLEDELAYEDEXPANSION`
- Helper functions for bash scripts can be put in [lib](lib) and should have a `#!/bin/bash` shebang as well as the `.bash` file extension, helper batch scripts with functions should also be located at [lib](lib) and should end with the `.cmd` file extension
- Do not put aliases in the helper libraries that can be load from scripts, because aliases are only supported in interactive shells and thus should only be part of the init.d load chain
- Full fledged scripts which should be available everywhere will be put in [bin](bin) (all platforms) or the appropriate subdirectory in [bin](bin) (always favoured by the `PATH` priority), these should provide full argument parsing support with help documentation and such
