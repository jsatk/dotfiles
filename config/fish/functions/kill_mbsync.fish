function kill_mbsync --description 'Sometimes mbsync gets stuck running and I want to kill it'
	ps aux | grep mbsync | grep -v grep | awk '{print $2}' | xargs -n 1 kill
end
