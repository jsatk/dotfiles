/**
 * Returns a string containing the currently playing song and artist for use
 * in tmux prompt * If you wish to use this outside of tmux update the
 * `pinkMusicNote` const.
 */
(function () {
  const noMusic = "🔇 "
  const pinkMusicNote = '#[fg=colour125]♬#[fg=colour232] '
  const itunes = Application('iTunes')
  const spotify = Application('Spotify')
  const itunesIsPlaying = itunes.running() && itunes.playerState() === 'playing'
  const spotifyIsPlaying = spotify.running() && spotify.playerState() === 'playing'
  const trim = 80 // Trim string at the 80th character.  Change this if you wish for a different max length or remove the `.substr` calls entirely if you wish for no trimming.

  if (itunesIsPlaying) {
    const track = itunes.currentTrack
    const artist = track.artist()
    const title = track.name()

    return (`${pinkMusicNote} ${title} - ${artist}`).substr(0, trim)
  }

  if (spotifyIsPlaying) {
    const track = spotify.currentTrack
    const artist = track.artist()
    const title = track.name()

    return (`${pinkMusicNote} ${title} - ${artist}`).substr(0, trim)
  }

  return noMusic
})()
