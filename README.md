# Firebird 3.0.14

Development image for `linux/amd64` on **Debian 13 (Trixie)**, the Debian Stable release when [Firebird 3.0.14](https://github.com/FirebirdSQL/firebird/releases/tag/v3.0.14) shipped on 2026-04-17. It uses the upstream AMD64 archive and SHA-256-pinned Debian 12 compatibility packages for `libncurses5` and `libtinfo5`.

Docker Hub: [`dcms/firebird-docker:3.0.14`](https://hub.docker.com/r/dcms/firebird-docker/tags?name=3.0.14)

From this directory:

```sh
export SYSDBAPASS="$(openssl rand -hex 4)"
docker compose up --build -d
bash smoke.sh firebird-local:3.0.14
```

Connect to `127.0.0.1:3050` as `SYSDBA` with `SYSDBAPASS`. Database files live under `/db`. `FIREBIRD_HOST_PORT` and `FIREBIRD_HOST_AUX_PORT` override the loopback ports. For development only.
