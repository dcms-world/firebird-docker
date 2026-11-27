# Firebird 4.0.7

Development image on **Debian 13 (Trixie)** for **`linux/amd64`**. It uses the [official Firebird 4.0.7 release](https://github.com/FirebirdSQL/firebird/releases/tag/v4.0.7) and verifies the archive's SHA-256 during the build.

**Docker Hub:** `dcms/firebird-docker:4.0.7` is the intended tag; publication is pending.

## Build and test locally

Run from the repository root:

```sh
docker build -t firebird-local:4.0.7 images/4.0.7
bash images/4.0.7/smoke.sh firebird-local:4.0.7
```

The smoke test connects over a published loopback TCP port, creates a database, checks the engine version and query result, and cleans up the test container.

## Run a development server

```sh
SYSDBAPASS=$(openssl rand -hex 4)
export SYSDBAPASS
docker run --rm -d --name firebird-4.0.7 -e SYSDBAPASS \
  -p 127.0.0.1:3050:3050 -v firebird407-data:/db firebird-local:4.0.7
```

Connect to `127.0.0.1:3050` as `SYSDBA` with the password in `SYSDBAPASS`. Store database files under `/db` to keep them in the named volume. The example only binds to loopback. This image is for development, not production.
