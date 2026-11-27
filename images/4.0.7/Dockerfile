FROM debian:13-slim

LABEL maintainer="Johann Zehner <hans@dcms.at>"
LABEL firebirdversion="4.0.7"

ARG FBDOWNLOAD=https://github.com/FirebirdSQL/firebird/releases/download/v4.0.7/Firebird-4.0.7.3271-0.amd64.tar.gz
ARG FBSHA256=d2964dfb190d7b0ec57271b53e6539f715ecc119f1cb8cd10339662eed9a7dea
ARG SYSDBAPASSWORD=masterkey
ENV SYSDBAPASS=${SYSDBAPASSWORD} FIREBIRD_PORT=3050 REMOTE_AUX_PORT=3051
COPY startup.sh /startup.sh

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget ca-certificates procps libatomic1 libicu76 libncurses6 libtomcrypt1 libtommath1 netbase; \
    wget -q "$FBDOWNLOAD" -O /tmp/fb.tar.gz; \
    printf '%s  /tmp/fb.tar.gz\n' "$FBSHA256" | sha256sum -c -; \
    mkdir /tmp/fb /db; \
    tar -xf /tmp/fb.tar.gz -C /tmp/fb --strip-components=1; \
    cd /tmp/fb; ./install.sh -silent; \
    cd /; rm -rf /tmp/fb /tmp/fb.tar.gz; \
    apt-get purge -y --auto-remove wget ca-certificates; \
    rm -rf /var/lib/apt/lists/*; \
    chmod +x /startup.sh; \
    printf '\nDatabaseAccess = Full\nServerMode = SuperClassic\nWireCrypt = Enabled\nAuthServer = Legacy_Auth, Srp, Win_Sspi\nUserManager = Legacy_UserManager, Srp\n' >> /opt/firebird/firebird.conf

EXPOSE 3050 3051
VOLUME /db
CMD ["/startup.sh"]
