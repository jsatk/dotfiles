# Defined in /var/folders/ld/jpkqdkzn5f71slwtlmwzmf100000gp/T//fish.KtXPKt/ev.fish @ line 2
function ev --description 'Edit .vimrc'
	eval vim ~/.vimrc # Explicitly open it in vim, not what $EDITOR is set to.
end
