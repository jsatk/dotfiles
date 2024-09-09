function ll --description 'List all files colorized in long format, including "hidden" files.'
    eza --all --long --header --git $argv
end
