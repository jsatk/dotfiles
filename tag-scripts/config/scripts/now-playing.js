#!/usr/bin/env osascript -l JavaScript

(() => {
  const notPlaying = "🔇 "
  const nowPlaying = "🔊"
  const music = Application('Music')
  const spotify = Application('Spotify')
  const musicIsPlaying = music.running() && music.playerState() === 'playing'
  const spotifyIsPlaying = spotify.running() && spotify.playerState() === 'playing'
  const isPlaying = musicIsPlaying || spotifyIsPlaying

  return isPlaying ? nowPlaying : notPlaying
})()
