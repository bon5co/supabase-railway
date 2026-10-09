#!/bin/sh
set -e

# Railway mounts the volume at /var/lib/postgresql, owned by root. PGDATA is the "data"
# subdirectory, which the stock entrypoint creates and chowns itself.
mkdir -p /var/lib/postgresql
chown postgres:postgres /var/lib/postgresql

# pgsodium/vault derive their root key from a file that upstream keeps on a named volume.
# Keep it on the data volume instead, or every redeploy would orphan encrypted secrets.
rm -f /etc/postgresql-custom/pgsodium_root.key
ln -s /var/lib/postgresql/pgsodium_root.key /etc/postgresql-custom/pgsodium_root.key

# The init scripts read PGPASSWORD from the environment.
export PGPASSWORD="$POSTGRES_PASSWORD"

exec docker-entrypoint.sh postgres -c config_file=/etc/postgresql/postgresql.conf -c log_min_messages=fatal
