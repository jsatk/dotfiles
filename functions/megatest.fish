function megatest --description 'MEGA TEST'
  rake spec quality jshint js_quality jasmine:ci_with_metrics -v -t; and brakeman -q
end
