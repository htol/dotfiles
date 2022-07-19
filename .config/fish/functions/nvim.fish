function nvim
  if test (uname -s) = "Linux"
      ~/.local/nvim/nvim-linux64/bin/nvim $argv
  else
      /usr/bin/env nvim $argv
  end
end
