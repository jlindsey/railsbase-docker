#!/bin/sh
if [ $SHOULD_BUNDLE_INSTALL -eq 1 ]; then
  cd /app && bundle install --without development test
fi

