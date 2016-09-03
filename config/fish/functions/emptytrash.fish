function emptytrash --description 'Empty the Trash on all mounted volumes and the main HDD.'
	sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash
end
