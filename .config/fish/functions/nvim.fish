function nvim
  if test (uname -s) = "Linux"
      ~/.local/nvim/nvim-linux-x86_64/bin/nvim $argv
  else
      /usr/bin/env nvim $argv
  end
end
