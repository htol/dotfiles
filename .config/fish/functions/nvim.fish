function nvim
  if test "$OSTYPE" = "linux-gnu"  # Is this the Ubuntu system?
      ~/.local/nvim/nvim-linux64/bin/nvim $argv
  else
      /usr/bin/env nvim $argv
  end
end
