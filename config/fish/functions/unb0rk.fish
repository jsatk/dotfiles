function unb0rk --description "Murder Kake when it's being the worst"
	cd ~/khan/webapp; and make clean; and make deps; and pkill -f kake/server_main.py
end
