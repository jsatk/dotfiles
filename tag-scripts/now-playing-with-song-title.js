/**
 * Returns a string containing the currently playing song and artist for use in
 * tmux prompt * If you wish to use this outside of tmux update the
 * `rainbowTitle` const, otherwise you'll get a text string of the color
 * settings.
 */
(() => {
  const noMusic = "🔇 "
  const music = "🔊"
  const itunes = Application('iTunes')
  const spotify = Application('Spotify')
  const itunesIsPlaying = itunes.running() && itunes.playerState() === 'playing'
  const spotifyIsPlaying = spotify.running() && spotify.playerState() === 'playing'
  const isPlaying = itunesIsPlaying || spotifyIsPlaying
  const violet = "colour165"
  const indigo = "colour69"
  const blue = "colour39"
  const green = "colour82"
  const yellow = "colour226"
  const orange = "colour208"
  const red = "colour196"
  const rainbow = [violet, indigo, blue, green, yellow, orange, red]

  // Change this number if you wish for a different max length or
  // remove the `.substr` calls entirely if you wish for no trimming.
  const trim = 30 * (`#[fg=${violet}]`.length)

  const getRainbowChar = (char, i) =>
    `#[fg=${rainbow[(i % rainbow.length)]}]${char}`

  const makeRainbow = text =>
    text
      .split('')
      .map(getRainbowChar)
      .join('')

  const getTrack = () => {
    if (spotifyIsPlaying) {
      return spotify.currentTrack
    } else if (itunesIsPlaying) {
      return itunes.currentTrack
    }
  } 

  if (isPlaying) {
    const track = getTrack()
    const title = track.name()
    const rainbowTitle = makeRainbow(title)

    return (`${music} ${rainbowTitle}`).substr(0, trim)
  } else {
    return noMusic
  }
})()
