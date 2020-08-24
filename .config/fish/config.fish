if status --is-interactive
    keychain --agents ssh github id_rsa id_ed25519
end

begin
    set -l HOSTNAME (hostname)
    if test -f ~/.keychain/$HOSTNAME-fish
        source ~/.keychain/$HOSTNAME-fish
    end
end

theme_gruvbox dark soft
