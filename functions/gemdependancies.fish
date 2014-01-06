function gemdependancies --description Lists\ every\ gem\ installed\'s\ dependancies
	gem list | egrep '^.*[ ]' -o | gem dependency
end
