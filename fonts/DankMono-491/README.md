# Dank Mono (v0.491)

## Installation

It's recommended to use the `otf` files in the `otf/` folder if you're
on macOS, Linux, or any other Unix-based system.

On Window the `ttf` files in the `ttf/` folder are recommended to be
installed.

If you need help to install the font, here are some guides:

- [macOS](https://support.apple.com/en-gb/HT201749)
- [Windows](https://www.cnet.com/how-to/how-to-add-remove-and-modify-fonts-in-windows-10/)
- [Ubuntu](https://itsfoss.com/install-fonts-ubuntu-1404-1410/)

Installing both versions of the font files will cause trouble
on all systems, so please keep in mind to avoid this.

Please contact me if you run into any trouble during installation.

## Upgrade

When you upgrade to a new version, most OS’ will need the old font
files to be removed. This means that purely installing the new
ones over the old ones often doesn't produce the same effects.

## Code Editor Themes

To actually use the font effectively there are three things to do:

- Make sure your syntax theme makes use of italics
- Make sure your editor supports ligatures and has them enabled
- Make sure your font size is above 14px

The 14px minimum font size is of course not a rule but a minimum
guideline of what works on *most* systems. Depending on the pixel
density of your screen the font might look a little different or
render at different sizes. It's also worth noting that the font
is mostly designed to work on high-res Retina screens.

## Contributing

If you'd like to suggest changes or additions check out Dank Mono’s
[Spectrum community](https://spectrum.chat/dank-mono).

## Changelog

### v0.491 — 14 May 2018

This is a small patch that fixes ligatures for certain editors
and terminals, for instance macOS’ Terminal.app.
Instead of using the `liga` font feature, Dank Mono now uses `calt`.
This patch should also fix cursor bugs that occured in some editors,
like VSCode.

### v0.490 — 13 May 2018

This release patches a lot of glyphs, brings new ligatures,
and introduces a couple (but not all) greek letters.

- All blocks and powerline symbols are now sizes to fit the full line-height.
- New `__` ligatures that display as continuous lines
- `->`, `<-`, `/*`, and `*/` ligatures
- Fixes size and shape for italic `l` and `s`
- Fix ellipsis `…` glyph
- Fix lower double quotes `„` glyph
- Add 60 out of 71 greek glyphs (WIP)

The `dank-mono.css` file will now also be bundled with every
release. This is a vendored CSS file that contains base64’d
and chunked woff files. They’re generally more safe to include
in websites, if the goal is to make it harder for users to
just download the font without paying for it.

### v0.470 — 04 May 2018

This release brings a couple of small patches.
The spacing of the “s” has been fixed, and the “j”
and “t” have been reworked to match the new “f”
in v0.460. The case-diacritics have been removed
as they were too small, and some symbol’s sizes have
been increased.

### v0.460 — 30 April 2018

Reworked the "f". Its cross stroke is now lower and thicker to make
it appear more balanced compared to "a" and "e" and from a high-level
view. Its arc is is also more closed and wider filling the negative
space the letter left before.

## EULA

See the attached [EULA.md](EULA.md) file or visit: https://dank.sh/eula/

## Contact

© Grazil Ltd 2018. Registered in England under company number 11343489
1st Floor, Telecom House 125-135 Preston Road, Brighton BN1 6AF

For any questions please contact me at: phil@dank.sh

