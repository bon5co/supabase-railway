#!/bin/sh
set -e
# Private service behind the gateway: pin the port instead of taking Railway's injected one.
export PORT=3000
eval "$(node /usr/local/lib/supabase-keys.js "$AUTH_JWT_SECRET")"
export SUPABASE_ANON_KEY="$ANON_KEY" SUPABASE_SERVICE_KEY="$SERVICE_ROLE_KEY"
cd /app
exec docker-entrypoint.sh node apps/studio/server.js
