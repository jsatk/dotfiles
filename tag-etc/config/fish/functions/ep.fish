function ep --description 'Edit .plan'
    git -C ~/Developer/jsatk.us pull
    set ymd (date "+%m-%d-%Y")
    set cmd1 "normal! gg}}}}}O    * [$ymd](#$ymd)"
    set cmd2 'exe "normal! Go\<esc>o\<esc>"'
    set cmd3 "normal! i## $ymd"
    vim +Goyo -c "$cmd1" -c "$cmd2" -c "$cmd3" ~/Developer/jsatk.us/content/dotplan.md
    git -C ~/Developer/jsatk.us commit -am "Update .plan"
    git -C ~/Developer/jsatk.us push
end
