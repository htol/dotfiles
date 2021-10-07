# TODO:
Move all this staff to bootstrap  
Make components updatable

# Hello
Short notes for enviroment setup.

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
or if you have pyenv with virtualenv plugin
```
pyenv virtualenv 3.8.9 neovim3
pyenv activate neovim3
pip install neovim
pyenv deactivate
```
in .vimrc/init.vim
```
let g:python3_host_prog = '/home/YOUR_USER_NAME/.local/pyenv/versions/neovim3/bin/python'
```

# For nvim lsp
All supported lsps
```
GO111MODULE=on go get golang.org/x/tools/gopls@latest  # also for  gopls update
npm install -g vls # vue.js
npm install -g yaml-language-server
npm install -g vscode-json-languageserver
npm install -g pyright
npm install -g typescript typescript-language-server
```

# golang
```
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt install golang-1.16
```

# rust
```
curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
```

# java. jdtls
```
mkdir -p ~/.local/jdt-ls
cd ~/.local/jdt-ls
curl -LO https://download.eclipse.org/jdtls/milestones/1.4.0/jdt-language-server-1.4.0-202109161824.tar.gz
```

# sdkman && gradle
```
curl -s "https://get.sdkman.io" | bash
sdk install gradle
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
pyenv install 3.8.9
pyenv global 3.8.9
```

# poetry
```
echo 'export POETRY_HOME="$HOME/.local/poetry"' >> ~/.zshrc
echo 'export PATH="$POETRY_HOME/bin:$PATH"' >> ~/.zshrc
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - --no-modify-path
poetry config virtualenvs.in-project true
```

# ansible
```
git clone https://github.com/ansible/ansible.git ~/.local/ansible
pip install -r ~/.local/ansible/requirements.txt
```


# macosx soft
```
brew cask install firefox visual-studio-code libreoffice wireshark iterm2 virtualbox virtualbox-extension-pack vagrant vlc dash
```

# macosx system settings
Check bootstrap! There is already a banch of setting to configure macosx. Here is only often used.

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
