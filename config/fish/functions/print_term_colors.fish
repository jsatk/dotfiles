function print_term_colors --description "Print available terminal colors to stdout"
	for i in (seq 255)
		printf "\x1b[38;5;"$i"mcolour"$i"\n"
	end | column
end
