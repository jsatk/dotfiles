(() => {
  const noMusic = "🔇 "
  const music = "🔊 "
  const itunes = Application('iTunes')
  const spotify = Application('Spotify')
  const itunesIsPlaying = itunes.running() && itunes.playerState() === 'playing'
  const spotifyIsPlaying = spotify.running() && spotify.playerState() === 'playing'
  const musicIsPlaying = itunesIsPlaying || spotifyIsPlaying

  return musicIsPlaying ? music : noMusic
})()
