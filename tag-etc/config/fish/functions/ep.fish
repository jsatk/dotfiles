function ep --description "Edit .plan"
    git -C ~/Developer/jsatk.us pull
    vim +Goyo ~/Developer/jsatk.us/content/dotplan.md
    git -C ~/Developer/jsatk.us commit -am "Update .plan"
    git -C ~/Developer/jsatk.us push
end
