function AlignAssignments()
   " Patterns needed to locate assignment operators. "
   let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
   let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'
 
   " Locate block of code to be considered (same indentation, no blanks) "
   let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
   let firstline  = search('^\%(' . indent_pat . '\)\@!', 'bnW') + 1
   let lastline   = search('^\%(' . indent_pat . '\)\@!',  'nW') - 1
   if lastline < 0
       let lastline = line('$')
   endif
 
   " Find the column at which the operators should be aligned. "
   let max_align_col = 0
   let max_op_width  = 0
   for linetext in getline(firstline, lastline)
       " Does this line have an assignment in it? "
       let left_width = match(linetext, '\s*' . ASSIGN_OP)
       if left_width >= 0
           let max_align_col = max([max_align_col, left_width])
           let op_width      = strlen(matchstr(linetext, ASSIGN_OP))
           let max_op_width  = max([max_op_width, op_width + 1])
       endif
   endfor
 
   " Code needed to reformat lines so as to align operators. "
   let FORMATTER = '\=printf("%-*s%*s", max_align_col, submatch(1),
   \                                    max_op_width,  submatch(2))'
 
   " Reformat lines with operators aligned in the appropriate column. "
   for linenum in range(firstline, lastline)
       let oldline = getline(linenum)
       let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
       call setline(linenum, newline)
   endfor
endfunction
 
nmap <silent> ;= :call AlignAssignments()<cr>
