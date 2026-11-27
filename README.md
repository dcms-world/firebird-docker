# Firebird 4.0.6

Development image for `linux/amd64`, based on **Debian 12 (Bookworm)**, the Debian Stable release on 2025-07-15. Uses the [official Firebird package](https://github.com/FirebirdSQL/firebird/releases/tag/v4.0.6) with a pinned SHA-256.

Docker Hub: [`dcms/firebird-docker:4.0.6`](https://hub.docker.com/r/dcms/firebird-docker/tags?name=4.0.6)

```sh
docker pull dcms/firebird-docker:4.0.6
```

## Build and run

Run from this directory:

```sh
export SYSDBAPASS="$(openssl rand -hex 4)"
docker compose up --build -d
docker compose port firebird 3050
```

Connect to `127.0.0.1:3050` as `SYSDBA` using `SYSDBAPASS`. Store database files under `/db`. Set `FIREBIRD_HOST_PORT` and `FIREBIRD_HOST_AUX_PORT` if running several versions side by side. For development only.

## Test

```sh
bash smoke.sh firebird-local:4.0.6
```
