if functions -q theme_gruvbox
  theme_gruvbox dark soft
end


. ~/.config/common_env

cd

set KEYCHAIN_DIR "$HOME/.cache/keychain"

if status --is-interactive
  if [ -f /usr/bin/keychain ]
    keychain --dir $KEYCHAIN_DIR --agents ssh id_rsa id_ed25519
  end
end

begin
    set -l HOSTNAME (hostname)
    if test -f $KEYCHAIN_DIR/$HOSTNAME-fish
        source $KEYCHAIN_DIR/$HOSTNAME-fish
    end
end

fnm env --shell=fish | source

if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]
     export PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
end
