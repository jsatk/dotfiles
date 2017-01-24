#  __     ______     ______     ______     ______
# /\ \   /\  == \   /\  == \   /\  == \   /\  ___\
# \ \ \  \ \  __<   \ \  __<   \ \  __<   \ \ \____
#  \ \_\  \ \_\ \_\  \ \_____\  \ \_\ \_\  \ \_____\
#   \/_/   \/_/ /_/   \/_____/   \/_/ /_/   \/_____/

# Preamble {{{

# Author:     Jesse Atkinson
# Email:      jesse@jsatk.us
# Source:     https://github.com/jsatk/dotfiles/blob/master/irbrc
# Twitter:    @jsatk

# }}}

require 'irb/completion'
require 'date'
require 'irb/ext/save-history'

IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end

def pbpaste
  `pbpaste`
end
