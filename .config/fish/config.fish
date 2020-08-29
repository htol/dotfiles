theme_gruvbox dark soft

. ~/.config/common_env

cd

set KEYCHAIN_DIR "$HOME/.cache/keychain"

if status --is-interactive
    keychain --dir $KEYCHAIN_DIR --agents ssh id_rsa id_ed25519
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
