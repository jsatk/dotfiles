function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

  echo

  set_color magenta
  printf '%s' (whoami)
  set_color normal
  printf ' at '

  set_color yellow
  printf '%s' (hostname|cut -d . -f 1)
  set_color normal
  printf ' in '

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal
__terlar_git_prompt
  echo

  if test $last_status -eq 0
    set_color normal
    printf '><((°> '
  else
    set_color $fish_color_error
    printf '[%d] ><((ˣ> ' $last_status
  end

  set_color normal
end
