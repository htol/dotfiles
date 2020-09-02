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


# TODO:

Fisher plugins load refactoring in bootstrap.
