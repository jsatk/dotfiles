#!/bin/bash

# Sometimes wttr.in just stops working.  No idea why.  But when it does it
# returns a big ugly string that messes up my tmux status bar.  I'd rather it
# not do that.  So this is a simple catch that forces it to print nothing
# instead when it can't fetch the weather.
WEATHER=$(curl -s wttr.in?format="%c+%t&u")

if [[ $WEATHER == *Unknown* ]] || [[ $WEATHER == *Sorry* ]]; then
  echo ""
else
  echo "$WEATHER"
fi
