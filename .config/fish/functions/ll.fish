function ll --wraps=ls --description 'List contents of directory using long format for all files'
    ls -alvh --group-directories-first $argv
end
