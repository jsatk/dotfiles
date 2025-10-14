# Dank Mono CSS File

The `dank-mono.css` file includes a chunked version of
the Dank Mono font. Each chunk contains only a range of
glyphs, and the glyphs’ names are obfuscated.

The file is optimised for the assumption that the font
will always be used, since the woff files are embedded
in the file as base64. It’s probably best not to use this
file if you’re planning on letting the users’ browser
decide when to download the font files.

## Usage

Include the CSS file and use: `font-family: "dm";`

The `font-face` rules are set not to fall back to a
local font.
