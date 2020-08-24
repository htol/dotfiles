export PATH="$HOME/.local/pyenv/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v keychain 1>/dev/null 2>&1; then
  eval `keychain --eval --agents ssh id_rsa id_ed25519`
else
  echo "Keychain not installed"
fi

autoload colors
colors

setopt prompt_subst

# zsh gentoo theme
function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~) $(git_prompt_info)$(prompt_char)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
