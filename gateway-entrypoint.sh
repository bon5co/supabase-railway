#!/bin/sh
set -e
if [ -z "$DASHBOARD_PASSWORD" ]; then
	echo "gateway: DASHBOARD_PASSWORD is not set" >&2
	exit 1
fi
DASHBOARD_PASSWORD_HASH="$(caddy hash-password --plaintext "$DASHBOARD_PASSWORD")"
export DASHBOARD_PASSWORD_HASH
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
