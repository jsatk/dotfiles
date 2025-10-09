function doc \
	--argument-names lang \
	--description "Quickly look up docs in terminal"
	set -e argv[1] # Drop `lang` from the arguments list.  There's probably a cleaner way to do this but ¯\_(ツ)_/¯
	if test "$lang" = "go"
		set --local lang "golang"
	end

	set --local query (urlencode $argv)
	w3m "https://duckduckgo.com/?q=$lang+$query"
end
