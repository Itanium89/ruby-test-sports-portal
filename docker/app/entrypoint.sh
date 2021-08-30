#!/bin/sh
set -e
#TODO can be moved to steps before docker-compose up?
bundle install

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi
exec "$@"