function ep --description "Edit .plan"
    git -C ~/.plan pull
    vim +Goyo ~/.plan
    git -C ~/.plan commit -am "Update"
    git -C ~/.plan push
end
