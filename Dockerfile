FROM debian:12.10-slim

LABEL maintainer="Johann Zehner <hans[at]dcms.at>"
LABEL firebirdversion="3.0.12"

ARG FBDOWNLOAD=https://github.com/FirebirdSQL/firebird/releases/download/v3.0.12/Firebird-3.0.12.33787-0.amd64.tar.gz
ARG SYSDBAPASSWORD=masterkey
ARG FBPORT=3050
ARG AUXPORT=3051

ENV SYSDBAPASS=${SYSDBAPASSWORD}
ENV FIREBIRD_PORT=${FBPORT}
ENV REMOTE_AUX_PORT=${AUXPORT}

COPY startup.sh /startup.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    procps  \
	ca-certificates \
	libtommath1 \
	libncurses5 \
	libicu72 && \
    rm -rf /var/lib/apt/lists/* && \
    ln -sf /usr/lib/x86_64-linux-gnu/libtommath.so.1 /usr/lib/x86_64-linux-gnu/libtommath.so.0 && \
    wget ${FBDOWNLOAD} -P /root && \
    tar -xvf /root/Firebird*.tar.gz  -C /root/ && \
    cd /root/Firebird* && \
    ./install.sh -silent && \
    rm -r /root/Firebird* && \
    apt-get remove -y \
	wget \
	ca-certificates && \
    apt-get autoremove -y && \
    mkdir /db && \
    chmod +x /startup.sh

RUN echo "ServerMode = Super" > /opt/firebird/firebird.conf && \ 
    echo "WireCrypt = Disabled" >> /opt/firebird/firebird.conf && \ 
    echo "AuthServer = Legacy_Auth" >> /opt/firebird/firebird.conf && \ 
    echo "AuthClient = Legacy_Auth" >> /opt/firebird/firebird.conf && \ 
    echo "UserManager = Legacy_UserManager" >> /opt/firebird/firebird.conf

VOLUME /db

CMD [ "./startup.sh" ]
