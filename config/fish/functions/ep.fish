function ep --description 'Edit .plan'
    git -C ~/.plan pull
    vim ~/.plan/README.markdown
    git -C ~/.plan commit -am 'Update'
    git -C ~/.plan push
end
