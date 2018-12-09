function rctag \
	--argument file tag \
	--description "Move a previously existing ~/.dotfiles file into a ~/.dotfiles/tag folder"
	trash ~/.$file; \
		and mv $file ~/.$file; \
		and mkrc -t $tag ~/.$file; \
		and rcup -t $tag
end
