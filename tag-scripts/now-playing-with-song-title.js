/**
 * Returns a string containing the currently playing song and artist for use in
 * tmux prompt * If you wish to use this outside of tmux update the
 * `rainbowTitle` const, otherwise you'll get a text string of the color
 * settings.
 */
(() => {
  const notPlaying = "🔇 "
  const nowPlaying = "🔊"
  const music = Application('Music')
  const spotify = Application('Spotify')
  const musicIsPlaying = music.running() && music.playerState() === 'playing'
  const spotifyIsPlaying = spotify.running() && spotify.playerState() === 'playing'
  const isPlaying = musicIsPlaying || spotifyIsPlaying
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
    } else if (musicIsPlaying) {
      return music.currentTrack
    }
  } 

  if (isPlaying) {
    const track = getTrack()
    const title = track.name()
    const rainbowTitle = makeRainbow(title)

    return (`${nowPlaying} ${rainbowTitle}`).substr(0, trim)
  } else {
    return notPlaying
  }
})()
