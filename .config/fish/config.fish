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

theme_gruvbox dark soft
