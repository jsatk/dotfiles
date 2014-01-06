function todos --description 'List TODO/FIXME lines from the current project. Requires ack: http://beyondgrep.com'
	ack --nogroup '(TODO|FIX(ME)?):'
end
