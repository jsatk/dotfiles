function consolelogs --description 'List console.logs from the current project'
	ack --nogroup '(console\.log|console\.info)'
end
