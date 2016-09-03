function urldecode --description 'Convert URL encoded string to JSON'
	python -c "import urllib, sys; print urllib.unquote('$argv')"
end
