# supabase-railway

Thin wrapper images that let the self-hosted [Supabase](https://github.com/supabase/supabase) stack
run as a Railway template with nothing to fill in at deploy time.

Each `Dockerfile.*` is `FROM` the pinned upstream image plus the settings upstream passes as
literal environment variables in its `docker-compose.yml`. Railway drops literal template-variable
defaults, so they live in the image instead; only secrets and cross-service references stay as
template variables.

- `db` — `supabase/postgres` with upstream's init SQL baked in; the pgsodium root key is kept on the data volume.
- `auth`, `rest`, `realtime`, `storage`, `meta`, `studio` — upstream services, settings baked in.
- `studio` and `storage` derive the `anon` and `service_role` API keys from the JWT secret at boot (`keys.js`).
- `gateway` — Caddy routing `/auth/v1`, `/rest/v1`, `/realtime/v1`, `/storage/v1` and the Studio dashboard behind a login.

Images are built by `.github/workflows/publish.yml` and published to `ghcr.io/bon5co/supabase-railway-<name>`.
