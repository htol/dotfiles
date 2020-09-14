function l --wraps=ls --description 'List contents of directory using long format'
    ls -lvh --group-directories-first $argv
end
