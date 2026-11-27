FROM debian:12-slim

LABEL maintainer="Johann Zehner <hans@dcms.at>"
LABEL firebirdversion="4.0.6"

ARG FBDOWNLOAD=https://github.com/FirebirdSQL/firebird/releases/download/v4.0.6/Firebird-4.0.6.3221-0.amd64.tar.gz
ARG FBSHA256=6ff5f672e10ee38ec5fc5394012ac83fe19872543dd2fefa249c1ccf62bc0075
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
    printf '\nDatabaseAccess = Full\nServerMode = SuperClassic\nWireCrypt = Enabled\nAuthServer = Legacy_Auth, Srp, Win_Sspi\nUserManager = Legacy_UserManager, Srp\n' >> /opt/firebird/firebird.conf

EXPOSE 3050 3051
VOLUME /db
CMD ["/startup.sh"]
