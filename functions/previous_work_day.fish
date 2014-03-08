function previous_work_day --description 'Prints out the previous work day.'
  if date '+%A'  == 'Monday'
    echo 'last friday'
  else
    echo 'yesterday'
  end
end
