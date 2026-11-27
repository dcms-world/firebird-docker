# Firebird 3.0.2

Legacy development image for `linux/amd64` on **Debian 8 (Jessie)**, the Debian Stable release when Firebird 3.0.2 shipped. Do not use in production. The archived upstream binary and Debian dependency packages are checked against pinned SHA-256 digests.

Docker Hub: [`dcms/firebird-docker:3.0.2`](https://hub.docker.com/r/dcms/firebird-docker/tags?name=3.0.2)

From this directory:

```sh
export SYSDBAPASS="$(openssl rand -hex 4)"
docker compose up --build -d
bash smoke.sh firebird-local:3.0.2
```

Connect to `127.0.0.1:3050` as `SYSDBA` using `SYSDBAPASS`. Database files live under `/db`. To run multiple versions in parallel, override the loopback ports using `FIREBIRD_HOST_PORT` and `FIREBIRD_HOST_AUX_PORT`.
