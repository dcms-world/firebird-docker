# Firebird 4.0.1

Development image for `linux/amd64`, based on **Debian 11 (Bullseye)**, the Debian Stable release on 2021-12-22. Uses the [official Firebird package](https://github.com/FirebirdSQL/firebird/releases/tag/v4.0.1) with a pinned SHA-256. Debian 11 is past its standard support lifecycle; use this only for legacy testing.

Docker Hub: [`dcms/firebird-docker:4.0.1`](https://hub.docker.com/r/dcms/firebird-docker/tags?name=4.0.1)

```sh
docker pull dcms/firebird-docker:4.0.1
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
bash smoke.sh firebird-local:4.0.1
```
