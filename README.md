# requirements
I mosly using ubuntu currently 20.04 TLS. Next packages should be enough for everything in bootstrap.
```
sudo apt update && sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git mc tmux fish fzf \
python3-venv openssh-server keychain unzip zip p7zip-full btop
```
- Feel free to remove 'openssh-server' or 'mc' if you don't need it on desktop.
- Check system version of python3 to edit 'pythonX.Y-venv package' it's required by poetry.

# bootstrap
From script on github
```
curl -fsSL https://raw.githubusercontent.com/htol/dotfiles/master/.local/bin/deploy_yadm.sh | bash
```

Manual

```
git clone https://github.com/TheLocehiliosan/yadm.git ~/.local/yadm-project
mkdir -p ~/.local/bin
ln -s ~/.local/yadm-project/yadm ~/.local/bin/yadm
~/.local/bin/yadm clone --bootstrap https://github.com/htol/dotfiles.git
```
Further setup can be found [here](https://github.com/htol/dotfiles/blob/master/.config/SETUP.md)
