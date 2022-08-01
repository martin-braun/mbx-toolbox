# mbx-toolbox
Martin Braun's eXtensive toolbox

## Disclaimer

Use at your own risk. I will not be responsible for any damage that might occur whilst using my toolbox.

## Installation

### MacOS

```zsh
sudo mkdir -p /usr/local/mbx && sudo chown "$(whoami)" /usr/local/mbx
git clone git@github.com:martin-braun/mbx-toolbox.git /usr/local/mbx
echo 'export PATH=$PATH:/usr/local/mbx/bin:/usr/local/mbx/obin/mac' >> ~/.zshrc
echo "test -e /usr/local/mbx/lib/init.zsh && . /usr/local/mbx/lib/init.zsh --source-only" >> ~/.zshrc
```

## Update

```sh
mbx-update
```

## Uninstall

```sh
rm -r /usr/local/mbx
```
