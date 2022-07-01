function l --wraps=ls --description 'List contents of directory using long format'
  if test "$OSTYPE" = "linux-gnu"  # Is this the Ubuntu system?
      ls -lhv --group-directories-first $argv
  else
      ls -lhv $argv
  end
end
