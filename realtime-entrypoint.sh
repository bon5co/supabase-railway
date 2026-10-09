#!/bin/sh
set -e
export PORT=4000
exec /usr/bin/tini -s -g -- /app/run.sh /app/bin/server
