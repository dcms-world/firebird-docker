#!/usr/bin/env bash
# Test a real Firebird connection via the Docker host's loopback port.
set -euo pipefail
image=${1:?image required}
export SYSDBAPASS
SYSDBAPASS=$(openssl rand -hex 4)
server=$(docker run --pull=never --rm -d -p 127.0.0.1::3050 -e SYSDBAPASS "$image")
trap 'docker stop -t 2 "$server" >/dev/null 2>&1 || true' EXIT
endpoint=$(docker port "$server" 3050/tcp)
port=${endpoint##*:}
for attempt in {1..20}; do
    if result=$({ printf '%s\n' "$SYSDBAPASS"; printf '%s\n' "CREATE DATABASE '127.0.0.1/$port:/db/verify.fdb';"; cat <<'SQL'
SET LIST ON;
SELECT RDB$GET_CONTEXT('SYSTEM', 'ENGINE_VERSION') AS ENGINE_VERSION,
       RDB$GET_CONTEXT('SYSTEM', 'NETWORK_PROTOCOL') AS NETWORK_PROTOCOL,
       42 AS SMOKE_RESULT FROM RDB$DATABASE;
DROP DATABASE;
QUIT;
SQL
    } | docker run --pull=never --rm -i --network host --entrypoint /bin/bash "$image" -c '
        read -r ISC_PASSWORD; export ISC_PASSWORD
        exec timeout 5 /opt/firebird/bin/isql -b -q -user SYSDBA' 2>&1); then
        printf '%s\n' "$result"
        grep -Eq '^ENGINE_VERSION[[:space:]]+5\.0\.3([.][0-9]+)?[[:space:]]*$' <<< "$result"
        grep -Eq '^NETWORK_PROTOCOL[[:space:]]+TCPv4[[:space:]]*$' <<< "$result"
        grep -Eq '^SMOKE_RESULT[[:space:]]+42[[:space:]]*$' <<< "$result"
        exit 0
    fi
    sleep 1
done
printf '%s\n' "$result" >&2
docker logs "$server" >&2 || true
exit 1
