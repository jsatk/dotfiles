/**
 * Returns a string containing the currently playing song and artist for use in
 * tmux prompt * If you wish to use this outside of tmux update the
 * `pinkMusicNote` const, otherwise you'll get a text string of the color
 * settings.
 */
(() => {
  const noMusic = "🔇 "
  const pinkMusicNote = '#[fg=colour125]♬#[fg=colour255] '
  const itunes = Application('iTunes')
  const spotify = Application('Spotify')
  const itunesIsPlaying = itunes.running() && itunes.playerState() === 'playing'
  const spotifyIsPlaying = spotify.running() && spotify.playerState() === 'playing'
  // Trim string at the 64th character.  Why 64?  Because `pinkMusicNote` is 34
  // characters long and 30 + 34 = 64.  30 characters seems like a reasonable
  // max for song title.
  //
  // Change this if you wish for a different max length or
  // remove the `.substr` calls entirely if you wish for no trimming.
  const trim = 64

  if (itunesIsPlaying) {
    const track = itunes.currentTrack
    // Not used currently but leaving here for easy future use if I change my mind.
    const artist = track.artist()
    const title = track.name()

    return (`${pinkMusicNote} ${title}`).substr(0, trim)
  }

  if (spotifyIsPlaying) {
    const track = spotify.currentTrack
    // Not used currently but leaving here for easy future use if I change my mind.
    const artist = track.artist()
    const title = track.name()

    return (`${pinkMusicNote} ${title}`).substr(0, trim)
  }

  return noMusic
})()
