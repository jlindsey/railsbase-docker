#!/bin/sh
if [ $SHOULD_DB_MIGRATE -eq 1 ]; then
  cd /app && bundle exec rake db:migrate
fi

