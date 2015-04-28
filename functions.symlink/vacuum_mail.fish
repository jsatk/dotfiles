function vacuum_mail --description Vacuum\ Mail.app\'s\ inbox\ which\ speeds\ up\ performance
  sqlite3 ~/Library/Mail/V2/MailData/Envelope\ Index vacuum $argv
end
