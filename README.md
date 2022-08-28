# mbx-toolbox
Martin Braun's eXtensive toolbox

Bash/Batch helper libraries/aliases/functions for Windows, MacOS and Debian (based) distributions.

## Disclaimer

Use at your own risk. I will not be responsible for any damages that might occur whilst using my toolbox.

## Installation

### Debian (incl. Proxmox)

```bash
apt update && apt install git -y
sudo mkdir -p /usr/local/mbx
sudo chown "$(whoami)" /usr/local/mbx
git clone https://github.com/martin-braun/mbx-toolbox.git /usr/local/mbx
echo 'export PATH=$PATH:/usr/local/mbx/bin/deb:/usr/local/mbx/bin' >> $HOME/.bashrc
echo "test -e /usr/local/mbx/lib/init.bash && . /usr/local/mbx/lib/init.bash" >> $HOME/.bashrc
```

### MacOS

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git
sudo mkdir -p /usr/local/mbx
sudo chown "$(whoami)" /usr/local/mbx
git clone https://github.com/martin-braun/mbx-toolbox.git /usr/local/mbx
echo 'export PATH=$PATH:/usr/local/mbx/bin/mac:/usr/local/mbx/bin' >> $HOME/.zshrc
echo "test -e /usr/local/mbx/lib/init.zsh && . /usr/local/mbx/lib/init.zsh" >> $HOME/.zshrc
```

### Windows

Within privileged command-line terminal (not PowerShell):

```cmd
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install git -y
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d @^%USERPROFILE^%\autorun.cmd" "2^>NUL /f
```

Then, within unprivileged command-line terminal (not PowerShell):

```cmd
MKDIR %ALLUSERSPROFILE%\mbx
git clone https://github.com/martin-braun/mbx-toolbox.git %ALLUSERSPROFILE%\mbx
SETX PATH "%PATH%;%ALLUSERSPROFILE%\mbx\bin\win;%ALLUSERSPROFILE%\mbx\bin"
ECHO @CALL %ALLUSERSPROFILE%\mbx\lib\init.cmd>>"%USERPROFILE%\autorun.cmd"
```

### Final steps

To validate your installation, restart your terminal and run `mbx-version`. It should print out the [current version](VERSION) to the console.

## Update

```sh
mbx-update
```
		
## Uninstall

### Windows

```cmd
DEL /S %ALLUSERSPROFILE%\mbx
rundll32 sysdm.cpl,EditEnvironmentVariables
```

Now remove the paths `%ALLUSERSPROFILE%\mbx\bin\win` and `%ALLUSERSPROFILE%\mbx\bin` from your `%PATH%` variable. Also remove the added lines in `%USERPROFILE%\autorun.cmd`.

### \*nix

```sh
rm -r /usr/local/mbx
```

Also remove the lines you added to your .bashrc/.zshrc during installation process.

## Contribute

Feel free to open an issue or even expand this toolkit:

- Simple functions or aliases that should be only available in an interactive shell need to be put in [lib/init.d](lib/init.d) and should always use the `#!/bin/sh` shebang and the `.sh` file extension to be imported with maximum compatibility in \*nix scripts, Windows scripts should always end up with `.cmd` and should work without `ENABLEDELAYEDEXPANSION`
- Helper functions for bash scripts can be put in [lib](lib) and should have a `#!/bin/bash` shebang as well as the `.bash` file extension, helper batch scripts with functions should also be located at [lib](lib) and should end with the `.cmd` file extension
- Do not put aliases in the helper libraries that can be load from scripts, because aliases are only supported in interactive shells and thus should only be part of the init.d load chain
- Full fledged scripts which should be available everywhere will be put in [bin](bin) (all platforms) or the appropriate subdirectory in [bin](bin) (always favoured by the `PATH` priority), these should provide full argument parsing support with help documentation and such
