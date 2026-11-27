FROM debian:13-slim

LABEL maintainer="Johann Zehner <hans@dcms.at>"
LABEL firebirdversion="3.0.14"

ARG FBDOWNLOAD=https://github.com/FirebirdSQL/firebird/releases/download/v3.0.14/Firebird-3.0.14.33856-0.amd64.tar.gz
ARG FBSHA256=d6fedba1108a46cea2b5f753674046fff0e43c6af27ba01657511635cbc9670f
ARG SYSDBAPASSWORD=masterkey
ENV SYSDBAPASS=${SYSDBAPASSWORD} FIREBIRD_PORT=3050 REMOTE_AUX_PORT=3051
COPY startup.sh /startup.sh

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget ca-certificates procps libatomic1 libicu76 libncurses6 libtomcrypt1 libtommath1 netbase; \
    wget -q https://deb.debian.org/debian/pool/main/n/ncurses/libtinfo5_6.4-4_amd64.deb -O /tmp/libtinfo5.deb; \
    wget -q https://deb.debian.org/debian/pool/main/n/ncurses/libncurses5_6.4-4_amd64.deb -O /tmp/libncurses5.deb; \
    printf '%s\n' 'dd347f794e651039e7b4c391f86c674fed7f415b3dca6b0937beb0d470f09c1a  /tmp/libtinfo5.deb' '02f4f7f52c4ce2fc4021793a931bfd85f7870554b8e4d56576d73a4ed0bdb390  /tmp/libncurses5.deb' | sha256sum -c -; \
    dpkg -i /tmp/libtinfo5.deb /tmp/libncurses5.deb; \
    rm /tmp/libtinfo5.deb /tmp/libncurses5.deb; \
    ln -s /usr/lib/x86_64-linux-gnu/libtommath.so.1 /usr/lib/x86_64-linux-gnu/libtommath.so.0; \
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
