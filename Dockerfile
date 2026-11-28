FROM debian:12-slim

LABEL maintainer="Johann Zehner <hans@dcms.at>"
LABEL firebirdversion="5.0.3"

ARG FBDOWNLOAD=https://github.com/FirebirdSQL/firebird/releases/download/v5.0.3/Firebird-5.0.3.1683-0-linux-x64.tar.gz
ARG FBSHA256=ef281c53f85756288151a86831375c9ae668caaeccd1b18103d523ba8f444779
ARG SYSDBAPASSWORD=masterkey
ENV SYSDBAPASS=${SYSDBAPASSWORD} FIREBIRD_PORT=3050 REMOTE_AUX_PORT=3051
COPY startup.sh /startup.sh

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget ca-certificates procps libatomic1 libicu72 libncurses6 libtomcrypt1 libtommath1 netbase; \
    wget -q "$FBDOWNLOAD" -O /tmp/fb.tar.gz; \
    printf '%s  /tmp/fb.tar.gz\n' "$FBSHA256" | sha256sum -c -; \
    mkdir /tmp/fb /db; \
    tar -xf /tmp/fb.tar.gz -C /tmp/fb --strip-components=1; \
    cd /tmp/fb; ./install.sh -silent; \
    cd /; rm -rf /tmp/fb /tmp/fb.tar.gz; \
    apt-get purge -y --auto-remove wget ca-certificates; \
    rm -rf /var/lib/apt/lists/*; \
    chmod +x /startup.sh; \
    printf '\nDatabaseAccess = Full\nServerMode = SuperClassic\nWireCrypt = Enabled\nAuthServer = Srp256, Srp\nUserManager = Srp\n' >> /opt/firebird/firebird.conf

EXPOSE 3050 3051
VOLUME /db
CMD ["/startup.sh"]
