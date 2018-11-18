function ep --description "Edit .plan"
    git -C ~/Dropbox\ \(Personal\)/plan/ pull
    vim +Goyo ~/.plan
    git -C ~/Dropbox\ \(Personal\)/plan/ commit -am "Update"
    git -C ~/Dropbox\ \(Personal\)/plan/ push
end
