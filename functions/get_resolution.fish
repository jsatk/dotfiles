function get_resolution --description 'Prints the current screen resolution'
  system_profiler SPDisplaysDataType | grep Resolution $argv
end
