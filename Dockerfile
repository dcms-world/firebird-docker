# syntax=docker/dockerfile:1
# Debian dependency checksums are from the signed Jessie archive index.
FROM scratch AS packages
ADD --checksum=sha256:89740ad81d291d1220bec1afc5a6e3ae076ce86f85aa4ee9eeee2b7b5538abde https://downloads.sourceforge.net/project/firebird/firebird-linux-amd64/3.0.1-Release/Firebird-3.0.1.32609-0.amd64.tar.gz /payload/fb.tar.gz
ADD --checksum=sha256:708d4499e2f6344a77d903c2c03a958f5edac32f9adf5ff3da7b572bf307e980 https://archive.debian.org/debian/pool/main/i/icu/libicu52_52.1-8+deb8u7_amd64.deb /payload/libicu52.deb
ADD --checksum=sha256:d8d811a523240deb5d12d9418281630bcffa24e21e6a56f50ac877163776f6ac https://archive.debian.org/debian/pool/main/libt/libtommath/libtommath0_0.42.0-1.1_amd64.deb /payload/libtommath0.deb
ADD --checksum=sha256:3979bdd40c5666ef9bf71a5391ba01ad38e264f2ec96d289993f2a0805616dd3 https://archive.debian.org/debian/pool/main/n/netbase/netbase_5.3_all.deb /payload/netbase.deb

FROM debian:8-slim@sha256:b9b0e7354098cbd534861d7532c082fb81cdb4d893303ba1f322f52c9e583cd2
LABEL firebirdversion="3.0.1"
ENV SYSDBAPASS=masterkey FIREBIRD_PORT=3050 REMOTE_AUX_PORT=3051
COPY startup.sh /startup.sh
RUN --mount=type=bind,from=packages,source=/payload,target=/payload \
    set -eu; dpkg -i /payload/*.deb; \
    mkdir -p /tmp/fb /db; tar -xf /payload/fb.tar.gz --strip-components=1 -C /tmp/fb; \
    cd /tmp/fb; ./install.sh -silent; cd /; rm -rf /tmp/fb; \
    chmod +x /startup.sh; \
    printf '\nDatabaseAccess = Full\nServerMode = SuperClassic\nWireCrypt = Enabled\nAuthServer = Legacy_Auth, Srp, Win_Sspi\nUserManager = Legacy_UserManager, Srp\n' >> /opt/firebird/firebird.conf
EXPOSE 3050 3051
VOLUME /db
CMD ["/startup.sh"]
