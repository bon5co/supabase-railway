#!/bin/sh
set -e
eval "$(node /usr/local/lib/supabase-keys.js "$AUTH_JWT_SECRET")"
export ANON_KEY SERVICE_KEY="$SERVICE_ROLE_KEY"
exec docker-entrypoint.sh node dist/start/server.js
