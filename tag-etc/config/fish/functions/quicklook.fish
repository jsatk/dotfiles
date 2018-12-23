function quicklook --description Open\ preview\ of\ a\ file\ using\ macOS\'s\ Quick\ Look
	qlmanage -p 2> /dev/null $argv
end
