#!/bin/sh
if [ $SHOULD_PRECOMPILE_ASSETS -eq 1 ]; then
  cd /app && bundle exec rake assets:precompile
fi
