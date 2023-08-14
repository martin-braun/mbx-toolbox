MBX TOOLBOX
===========

Martin Braun's eXtensive toolbox

Bash/Batch helper libraries/aliases/functions for Windows, MacOS, Debian (based), Red Hat (based) distributions and Alpine Linux.

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
|`gitbr`|`all`|Outputs the current branch in the current directory.|
|`gitpb`|`all`|Pulls all branches and rebases the commits on the working changes|
|`gitpf`|`all`|Attempts to pull all branches and cancels the action on existing working changes.|
|`gitpa`|`all`|Pushes all branches to the remote.|
|`gitam`|`all`|Ammends the working changes into the last commit.|

### Interactive Functions

> Interactive functions will be load on any interactive shell automatically. While they could be called from a script, this is not supported. Their purpose is to run exclusively interactive. A reason for that decision is that the output of such functions is often inconsistent (between platforms) and its use is trivial. Treat those functions like aliases / DOSKEYs with argument support.

|Command|Platforms|Description|
|-|-|-|
|`locport <port>?`|`all`|Outputs process and connection information (of the given local port).|
|`gitco [ feat | fix | docs | style | refactor | test | chore ][!][@<scope>]? <...message>`|`all`|Commits the current working changes using semantic commit messages.|
|`gitfuse <branch...>`|`all`|Merges the current branch into the given branch or branches. Repository must not have working changes active.|
|`gitfind <text>`|`all`|Finds all commits of all branches with a given string in the description.|
|`meownr <path>`|`all`|Recursively claim ownership of any files and folders within and of a path.|
|`megrpr <path>`|`*nix`|Recursively claim ownership via group of any files and folders within and of a path.|
|`chownr <user>[:<group>]? <path>`|`*nix`|Recursively change ownership of any files and folders within and of a path to a specific user/group.|
|`chgrpr <group> <path>`|`*nix`|Recursively change ownership of any files and folders within and of a path to a specific group.|
|`nvm-install`|`win`|Smart nvm-install that will use the contents of .nvmrc as argument.|
|`nvm-use`|`win`|Smart nvm-use that will use the contents of .nvmrc as argument.|

### Helper Functions

> Helper functions can be called in your scripts and cannot be used in interactive shells. To call a helper function in your script use this while replacing `{LIBRARY}` with the library name and `{COMMAND}` with the function name and arguments: 
> 
> Bash: `. "$MBX_LIBPATH/{LIBRARY}.bash" || exit 1` in the header of your bash script, and then simply run `{COMMAND}` (you can use `if` to make conditions based on the return value, i.e. `if testcmd php; then; echo "PHP found"; fi`).
> 
> Batch: `CALL "%MBX_LIBPATH%\{LIBRARY}" load || EXIT /B` in the header of your batch script, and then run `CALL "%MBX_LIBPATH%\{LIBRARY}" {COMMAND}` (you can wrap these to make conditions based on the return value, i.e. `( CALL "%MBX_LIBPATH%\_" testcmd php ) && ECHO PHP found`).

|Library|Command|Platforms|Description|
|-|-|-|-|
|`_`|`subset <variableName> "<command>" [ /F ]`|`win`|Sets a variable to the output of a command substitution. (`/F` for slower file mode to return a correct errorlevel)|
|`_`|`testif [ /I ] [ NOT ] [ EXIST ] <string1> [ == \| EQU \| NEQ \| LSS \| LEQ \| GTR \| GEQ ] <string2>`|`win`|Performs conditional processing in batch programs. Is callable for inline use.|
|`_`|`testcmd <command>`|`all`|Test if a command can be executed. Do not pass additional arguments.|
|`tt`|`tolower <string>`|`*nix`|Transforms the given text into the lowercase format.|
|`tt`|`toupper <string>`|`*nix`|Transforms the given text into the uppercase format.|

### Scripts

> Scripts can be called from an interactive shell or they can be used from within any script. They are available in the `PATH` variable and function as full-fledged programs. Every script supports the `-h` flag to print out more help.

|Command|Platforms|Description|
|-|-|-|
|`chmodr [ -V \| -v \| -d=* \| -f=* \| -c \| -h ]`|`deb`,`rh`,`mac`|Recursively changes modes on directories and files individually. (`-d=*` sets the directory permissions.; `-f=*` sets the file permissions.; `-c` claims ownership of the directories and files.)|
|`git-src [ ls \| add \| up \| del ] <REPO?> [ -V \| -v \| -p \| -b \| -h ]`|`*nix`|Adds, updates or deletes git source files of third party vendors. (`ls` lists all locally added repositories/branches.; `add` clones the given repository/branch with all its submodules with depth of 1 into the localized source storage.; `up` resets and pulls the latest changes on the given repository/branch.; `del` deletes the given repository/branch from the system.; `-p=*` sets the working directory path (root) of the localized source storage (default: /usr/local/src/git).; `-b=*` sets the branch of the repo to work with.)|
|`mbx-upgrade [ -V \| -v \| -h ]`|`all`|Upgrades Martin Braun's eXtensive toolbox.|
|`sys-upgrade [ -V \| -v \| -r \| -h`|`all`|Upgrades all packages of all supported package managers. (`-r` reboots the system after successful upgrade.)|
|`sys-backup [ -V \| -v \| -p=* \| -m=* \| -k \| -l \| -s \| -h ]`|`deb`,`rh`,`mac`|Backups all files given a certain maximum size from the root directory of this system. On MacOS it launches Time Maschine backup instead. (`-p=*` sets the path to the backup directory if possible (default: `$HOME/.sys-backup`).; `-m=*` sets the maximum size of every backup-ed file (default: `10M`).; `-k` keeps the old backup files that are not overwritten. Ignored on MacOS.; `-l` locks the backup by rejecting access permissions to the current user. Ignored on MacOS.; `-s` shutdowns the system 5 minutes after successful system backup.)|

Installation
------------

### \*nix Systems

#### Debian based

For Debian-based distros simply run the following commands to install essential dependencies and the toolbox. You can run these commands as root, skip `sudo` in such case: 

```bash
sudo apt update && sudo apt install git -y # don't use sudo if you are root
sudo mkdir -p /usr/local/share/mbx # don't use sudo if you are root
sudo chown "$(whoami)" /usr/local/share/mbx # skip, if you are root
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git /usr/local/share/mbx
echo '' >> $HOME/.bashrc
echo '# mbx' >> $HOME/.bashrc
echo 'export MBX_PATH="/usr/local/share/mbx"' >> $HOME/.bashrc
echo 'export PATH=$PATH:$MBX_PATH/bin/deb:$MBX_PATH/bin' >> $HOME/.bashrc
echo 'test -e "$MBX_PATH/lib/init.sh" && . "$MBX_PATH/lib/init.sh"' >> $HOME/.bashrc
. $HOME/.bashrc
```

#### Red Hat based

For Red Hat-based distros simply run the following commands to install essential dependencies and the toolbox. You can run these commands as root, skip `sudo` in such case: 

```bash
sudo dnf install git --refresh -y # don't use sudo if you are root
sudo mkdir -p /usr/local/share/mbx # don't use sudo if you are root
sudo chown "$(whoami)" /usr/local/share/mbx # skip, if you are root
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git /usr/local/share/mbx
echo '' >> $HOME/.bashrc
echo '# mbx' >> $HOME/.bashrc
echo 'export MBX_PATH="/usr/local/share/mbx"' >> $HOME/.bashrc
echo 'export PATH=$PATH:$MBX_PATH/bin/rh:$MBX_PATH/bin' >> $HOME/.bashrc
echo 'test -e "$MBX_PATH/lib/init.sh" && . "$MBX_PATH/lib/init.sh"' >> $HOME/.bashrc
. $HOME/.bashrc
```

#### Alpine Linux (BusyBox)

For BusyBox based distros simply run the following commands to install essential dependencies and the toolbox. You can run these commands as root, skip `doas` in such case.: 

```bash
doas apk update # don't use doas if you are root
doas apk add git # don't use doas if you are root
doas mkdir -p /usr/local/share/mbx # don't use doas if you are root
doas chown "$(whoami)" /usr/local/share/mbx # skip, if you are root
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git /usr/local/share/mbx
echo '' >> $HOME/.profile
echo '# mbx' >> $HOME/.profile
echo 'export MBX_PATH="/usr/local/share/mbx"' >> $HOME/.profile
echo 'export PATH=$PATH:$MBX_PATH/bin/alp:$MBX_PATH/bin' >> $HOME/.profile
echo 'test -e "$MBX_PATH/lib/init.sh" && . "$MBX_PATH/lib/init.sh"' >> $HOME/.profile
. $HOME/.profile
```

#### MacOS

For MacOS, you should install Homebrew and use it to install a few essential dependencies to use this toolbox. Skip the fist command if Homebrew is already installed:

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git coreutils
sudo mkdir -p /usr/local/share/mbx
sudo chown "$(whoami)" /usr/local/share/mbx
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git /usr/local/share/mbx
echo '' >> $HOME/.zshrc
echo '# mbx' >> $HOME/.zshrc
echo 'export MBX_PATH="/usr/local/share/mbx"' >> $HOME/.zshrc
echo 'export PATH=$PATH:$MBX_PATH/bin/mac:$MBX_PATH/bin' >> $HOME/.zshrc
echo 'test -e "$MBX_PATH/lib/init.sh" && . "$MBX_PATH/lib/init.sh"' >> $HOME/.zshrc
. $HOME/.zshrc
```

### Windows

For Windows, you should install Chocolatey and use it to install a few essential dependencies to use this toolbox. For this run the following commands within a privileged command-line terminal (not PowerShell), skip the first command if Chocolatey is already installed:

```bat
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%PROGRAMDATA%\chocolatey\bin" && refreshenv
choco install git awk -y && refreshenv
MKDIR "%PROGRAMDATA%\mbx"
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git "%PROGRAMDATA%\mbx"
SET "MBX_PATH=%PROGRAMDATA%\mbx"
ECHO. >> %USERPROFILE%\autorun.cmd
ECHO @REM mbx >> %USERPROFILE%\autorun.cmd
ECHO @SET "MBX_PATH=%PROGRAMDATA%\mbx" >> "%USERPROFILE%\autorun.cmd"
ECHO @SET "PATH=^%PATH^%;^%MBX_PATH^%\bin\win;^%MBX_PATH^%\bin" >> "%USERPROFILE%\autorun.cmd"
ECHO @CALL "^%MBX_PATH^%\lib\init.cmd" >> "%USERPROFILE%\autorun.cmd"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d @^%USERPROFILE^%\autorun.cmd" "2^>NUL /f
```

> Note: You have to replace `^%` with `%%` if this will be automated in a batch script.

The last command will ensure that an autorun.cmd is sourced in a similar fashion like .bashrc on Linux. This is to enable alias support (DOSKEY) in your interactive shell.

#### MINGW64 (Git for Windows SDK, build-extra Git Bash)

Additionally to above steps, you can access \*nix tools in Windows through Git Bash (Git for Windows SDK). This is very experimental and can cause problems. Some scripts won't work in Git Bash:

```sh
echo '' >> $HOME/.zshrc
echo '# mbx' >> $HOME/.bashrc
echo 'export MBX_PATH="$ProgramData/mbx"' >> $HOME/.bashrc
echo 'export PATH=$PATH:$MBX_PATH/bin/deb:$MBX_PATH/bin' >> $HOME/.bashrc
echo 'test -e "$MBX_PATH/lib/init.sh" && . "$MBX_PATH/lib/init.sh"' >> $HOME/.bashrc
```

> Warning: XDG paths will collide between environments. You can complete this merge for maximum interoperability, just run this in your MSYS2 environment:
> 
> ```sh
> echo 'export XDG_CONFIG_DIRS="$XDG_CONFIG_DIRS:$ProgramData/xdg"' >> $HOME/.bashrc
> echo 'export XDG_DATA_DIRS="$XDG_DATA_DIRS:$ProgramData"' >> $HOME/.bashrc
> ``` 
> 
> But keep in mind that XDG paths will be shared between environments. If you have to have conflicting files, you can skip the above step and make sure to install this toolbox after installing the Git for Windows SDK. This way, XDG paths won't be linked together at the expense that XDG files cannot be shared between the environments. 

### Final steps

To validate your installation, restart your terminal and run `mbx-version`. It should print out the [current version](VERSION) to the console.

### Switching to the `dev` branch

If you want to test the latest changes, you can switch to the `dev` branch, but things might break. 

After installation run this in the MBX toolbox path (`/usr/local/share/mbx` or `%PROGRAMDATA%\mbx`):

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

### \*nix (Alpine / Debian / Red Hat / MacOS / etc.)

```sh
rm -r /usr/local/share/mbx
rm -r /usr/local/src/git # optional sources installed by git-src
```

Also remove the lines you added to your .bashrc/.zshrc during installation process.

### Windows

```cmd
DEL /S %PROGRAMDATA%\mbx
```

Now remove the added lines in `%USERPROFILE%\autorun.cmd`.

If you don't like to keep the auto-loader of the `autorun.cmd`, just remove the file and finalize your purge in an elevated shell with: 

```bat
reg remove "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun
```

Contribute
----------

Feel free to open an issue or even expand this toolbox:

- Simple functions or aliases that should be only available in an interactive shell need to be put in [lib/init.d](lib/init.d) and should always use the `#!/usr/bin/env sh` shebang and the `.sh` file extension to be imported with maximum compatibility in \*nix scripts, Windows scripts should always end up with `.cmd` and should work without `ENABLEDELAYEDEXPANSION`
- Helper functions for bash scripts can be put in [lib](lib) and should have a `#!/usr/bin/env bash` shebang as well as the `.bash` file extension, helper batch scripts with functions should also be located at [lib](lib) and should end with the `.cmd` file extension
- Do not put aliases in the helper libraries that can be load from scripts, because aliases are only supported in interactive shells and thus should only be part of the init.d load chain
- Full fledged scripts which should be available everywhere will be put in [bin](bin) (all platforms) or the appropriate subdirectory in [bin](bin) (always favoured by the `PATH` priority), these should provide full argument parsing support with help documentation and such
