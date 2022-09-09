# mbx-toolbox
Martin Braun's eXtensive toolbox

Bash/Batch helper libraries/aliases/functions for Windows, MacOS and Debian (based) distributions.

## Disclaimer

Use at your own risk. I will not be responsible for any damages that might occur whilst using my toolbox.

## Installation

### Debian (incl. Proxmox)

For Debian-based distros simply run the following commands to install essential dependencies and the toolbox. You can run these commands as root, skip sudo in such case: 

```bash
apt update && apt install git -y
sudo mkdir -p /usr/local/mbx # don't use sudo if you are root
sudo chown "$(whoami)" /usr/local/mbx # don't use sudo if you are root
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git /usr/local/mbx
echo 'export PATH=$PATH:/usr/local/mbx/bin/deb:/usr/local/mbx/bin' >> $HOME/.bashrc
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
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install git awk -y
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d @^%USERPROFILE^%\autorun.cmd" "2^>NUL /f
```

The last command will ensure that an autorun.cmd is sourced in a similar fashion like .bashrc on Linux. This is to enable alias support (DOSKEY) in your interactive shell.

Then, within unprivileged command-line terminal (not PowerShell) run the following commands to install this toolbox and autoload its DOSKEY entries via autorun.cmd:

```bat
MKDIR %ALLUSERSPROFILE%\mbx
git clone --depth 1 https://github.com/martin-braun/mbx-toolbox.git %ALLUSERSPROFILE%\mbx
SETX PATH "%PATH%;%ALLUSERSPROFILE%\mbx\bin\win;%ALLUSERSPROFILE%\mbx\bin"
ECHO @CALL %ALLUSERSPROFILE%\mbx\lib\init.cmd>>"%USERPROFILE%\autorun.cmd"
```

### Final steps

To validate your installation, restart your terminal and run `mbx-version`. It should print out the [current version](VERSION) to the console.

## Update

Straightforward:

```sh
mbx-update
```
		
## Uninstall

### \*nix (Debian / MacOS / etc.)

```sh
rm -r /usr/local/mbx
```

Also remove the lines you added to your .bashrc/.zshrc during installation process.

### Windows

```cmd
DEL /S %ALLUSERSPROFILE%\mbx
rundll32 sysdm.cpl,EditEnvironmentVariables
```

Now remove the paths `%ALLUSERSPROFILE%\mbx\bin\win` and `%ALLUSERSPROFILE%\mbx\bin` from your `%PATH%` variable. Also remove the added lines in `%USERPROFILE%\autorun.cmd`.

If you don't like to keep the auto-loader of the `autorun.cmd`, just remove the file and finalize your purge in an elevated shell with: 

```bat
REG REMOVE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun
```

## Contribute

Feel free to open an issue or even expand this toolkit:

- Simple functions or aliases that should be only available in an interactive shell need to be put in [lib/init.d](lib/init.d) and should always use the `#!/bin/sh` shebang and the `.sh` file extension to be imported with maximum compatibility in \*nix scripts, Windows scripts should always end up with `.cmd` and should work without `ENABLEDELAYEDEXPANSION`
- Helper functions for bash scripts can be put in [lib](lib) and should have a `#!/bin/bash` shebang as well as the `.bash` file extension, helper batch scripts with functions should also be located at [lib](lib) and should end with the `.cmd` file extension
- Do not put aliases in the helper libraries that can be load from scripts, because aliases are only supported in interactive shells and thus should only be part of the init.d load chain
- Full fledged scripts which should be available everywhere will be put in [bin](bin) (all platforms) or the appropriate subdirectory in [bin](bin) (always favoured by the `PATH` priority), these should provide full argument parsing support with help documentation and such
