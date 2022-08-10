# mbx-toolbox
Martin Braun's eXtensive toolbox

Bash 3 helper libraries with additional interactive shell functions/aliases for Debian (based) distros and MacOS.

## Disclaimer

Use at your own risk. I will not be responsible for any damages that might occur whilst using my toolbox.

## Installation

### Debian (incl. Proxmox)

```bash
sudo mkdir -p /usr/local/mbx && sudo chown "$(whoami)" /usr/local/mbx
git clone git@github.com:martin-braun/mbx-toolbox.git /usr/local/mbx
echo 'export PATH=$PATH:/usr/local/mbx/bin:/usr/local/mbx/bin/deb' >> $HOME/.bashrc
echo "test -e /usr/local/mbx/lib/init.zsh && . /usr/local/mbx/lib/init.zsh" >> $HOME/.bashrc
```

### MacOS

```zsh
sudo mkdir -p /usr/local/mbx && sudo chown "$(whoami)" /usr/local/mbx
git clone git@github.com:martin-braun/mbx-toolbox.git /usr/local/mbx
echo 'export PATH=$PATH:/usr/local/mbx/bin:/usr/local/mbx/bin/mac' >> $HOME/.zshrc
echo "test -e /usr/local/mbx/lib/init.zsh && . /usr/local/mbx/lib/init.zsh" >> $HOME/.zshrc
```

## Update

```sh
mbx-update
```
		
## Uninstall

```sh
rm -r /usr/local/mbx
```

Also remove the lines you added to your .bashrc/.zshrc during installation process.

## Contribute

Feel free to open an issue or even expand this toolkit:

- Simple functions or aliases that should be only available in an interactive shell need to be put in [lib/init.d](lib/init.d) and should always use the `#!/bin/sh` shebang and the `.sh` file extension to be imported with maximum compatibility
- Helper functions or aliases for bash scripts can be put in [lib](lib) and should have a `#!/bin/bash` shebang as well as the `.bash` file extension
- Full fledged scripts available everywhere will be put in [bin](bin) (all platforms) or the appropriate subdirectory in [bin](bin)

> IMPORTANT: Update the timestamp in [lib/init.d/mbx.sh](lib/init.d/mbx.sh) prior any pull requests
