function current_branch --description 'Print the name of the current git branch.'
	git branch | grep '*' | awk '{ print $2 }'
end
