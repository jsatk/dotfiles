function urlencode --description "Convert string to URL encoded string"
	python -c "import urllib, sys; print urllib.quote_plus('$argv')"
end
