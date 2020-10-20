FROM debian:9.4-slim

LABEL maintainer="Hans Zehner <hans[at]dcms.at>"
LABEL firebirdversion="3.0.6"

ARG FBDOWNLOAD=https://github.com/FirebirdSQL/firebird/releases/download/R3_0_6/Firebird-3.0.6.33328-0.amd64.tar.gz
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
	libtommath-dev \
	libncurses5 \
	libicu57 && \
    rm -rf /var/lib/apt/lists/* && \
    wget ${FBDOWNLOAD} -P /root && \
    tar -xvf /root/Firebird*.tar.gz  -C /root/ && \
    cd /root/Firebird* && \
    ./install.sh -silent && \
    ln -sf /usr/lib/x86_64-linux-gnu/libtommath.so.1 /usr/lib/x86_64-linux-gnu/libtommath.so.0 && \
    rm -r /root/Firebird* && \
    apt-get remove -y \
	wget \
	ca-certificates && \
    apt-get autoremove -y && \
    mkdir /db && \
    chmod +x /startup.sh && \
    echo "ServerMode = Super" > /opt/firebird/firebird.conf && \ 
    echo "WireCrypt = Disabled" >> /opt/firebird/firebird.conf && \ 
    echo "AuthServer = Legacy_Auth" >> /opt/firebird/firebird.conf && \ 
    echo "AuthClient = Legacy_Auth" >> /opt/firebird/firebird.conf && \ 
    echo "UserManager = Legacy_UserManager" >> /opt/firebird/firebird.conf


VOLUME /db


CMD [ "/startup.sh" ]
