# Firebird 4.0.7

Development image on **Debian 13 (Trixie)** for **`linux/amd64`**. It uses the [official Firebird 4.0.7 release](https://github.com/FirebirdSQL/firebird/releases/tag/v4.0.7) and verifies the archive's SHA-256 during the build.

**Docker Hub:** [`dcms/firebird-docker:4.0.7`](https://hub.docker.com/r/dcms/firebird-docker/tags?name=4.0.7)

```sh
docker pull dcms/firebird-docker:4.0.7
```

## Build and test locally

Run from the repository root:

```sh
docker build -t firebird-local:4.0.7 images/4.0.7
bash images/4.0.7/smoke.sh firebird-local:4.0.7
```

The smoke test connects over a published loopback TCP port, creates a database, checks the engine version and query result, and cleans up the test container.

## Run with Docker Compose

From the repository root, use Docker Compose v2.20 or later:

```sh
export SYSDBAPASS="$(openssl rand -hex 4)"
docker compose up --build -d
docker compose port firebird 3050
```

Both root Compose entry points use the version-specific `compose.yml` in this directory. `FIREBIRD_HOST_PORT` and `FIREBIRD_HOST_AUX_PORT` override the localhost ports (default `3050` and `3051`). After publication, run only the registry-based example with `docker compose -f docker-compose_sample.yml up -d fb407` (localhost port `3407`).

## Run without Compose

```sh
SYSDBAPASS=$(openssl rand -hex 4)
export SYSDBAPASS
docker run --rm -d --name firebird-4.0.7 -e SYSDBAPASS \
  -p 127.0.0.1:3050:3050 -v firebird407-data:/db firebird-local:4.0.7
```

Connect to `127.0.0.1:3050` as `SYSDBA` with the password in `SYSDBAPASS`. Store database files under `/db` to keep them in the named volume. The example only binds to loopback. This image is for development, not production.
