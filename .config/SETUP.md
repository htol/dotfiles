# Hello
Short notes for enviroment setup.

# zsh

```
brew: /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install golang mtr mc wget neovim tmux htop the_silver_searcher ripgrep
```
oh-my-zsh manual install
```
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.local/oh-my-zsh
```

# latest nvim for ubuntu before 20.04
```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
```
adding providers
```
python3 -m pip install --user --upgrade pynvim
npm install -g neovim
```

# install latest node.js through nvm
required for CoC
```
nvm install --lts node
```

# CoC plugins
```
:CocInstall coc-tsserver coc-json coc-html coc-css coc-go coc-python coc-snippets coc-yaml coc-vetur coc-sql
```

# golang
```
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt install golang-go
```

# pyenv
```
git clone https://github.com/pyenv/pyenv.git ~/.local/pyenv
echo 'export PYENV_ROOT="$HOME/.local/pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
```

Next packages are required to build python from source
```
sudo apt update && sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
```

Install python by pyenv
```
pyenv install 3.7.3
pyenv global 3.7.3
```

# poetry
```
echo 'export POETRY_HOME="$HOME/.local/poetry"' >> ~/.zshrc
echo 'export PATH="$POETRY_HOME/bin:$PATH"' >> ~/.zshrc
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
poetry config virtualenvs.in-project true
```

# ansible
```
git clone https://github.com/ansible/ansible.git ~/.local/ansible
pip install -r ~/.local/ansible/requirements.txt
```


telegram
iterm2
vscode
OneNote
Libre Office
https://www.wireshark.org
VLC
dash # API browser

```
brew cask install firefox visual-studio-code libreoffice wireshark iterm2 virtualbox virtualbox-extension-pack vagrant vlc
```

# macosx

fonts:
```
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 0
```

Don't create "DS_Store" on remote shares:
```
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
defaults read com.apple.desktopservices # check current policy
```
