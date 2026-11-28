# Firebird 5.0.4

Development image for `linux/amd64` on **Debian 13 (Trixie)**. It uses the official [Firebird 5.0.4 package](https://github.com/FirebirdSQL/firebird/releases/tag/v5.0.4), verified during the build using SHA-256. This image uses SRP authentication, not `Legacy_Auth`.

Docker Hub: [`dcms/firebird-docker:5.0.4`](https://hub.docker.com/r/dcms/firebird-docker/tags?name=5.0.4)

From this directory:

```sh
export SYSDBAPASS="$(openssl rand -hex 8)"
docker compose up --build -d
bash smoke.sh firebird-local:5.0.4
```

Connect to `127.0.0.1:3050` as `SYSDBA` using `SYSDBAPASS`. Database files live under `/db`. Override `FIREBIRD_HOST_PORT` and `FIREBIRD_HOST_AUX_PORT` to run versions side by side on loopback. For development only.
