cd

. ~/.config/common_env


if status --is-interactive
  if [ -f /usr/bin/keychain ]
    keychain --dir $KEYCHAIN_DIR --agents ssh id_rsa id_ed25519
  end
  set CDPATH . ~/repos ~/go/src ~/winrepos

  if functions -q theme_gruvbox
    theme_gruvbox dark soft
  end

  begin
    set -l HOSTNAME (hostname)
    if test -f $KEYCHAIN_DIR/$HOSTNAME-fish
        source $KEYCHAIN_DIR/$HOSTNAME-fish
    end
  end

end


fnm env --shell=fish | source

if test -f ~/.local/pyenv/bin/pyenv
  pyenv init - | source
end

if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]
     export PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
end

alias serveron "ipmitool -H 192.168.55.3 -U ADMIN chassis power on"

