FROM debian:9.13-slim

LABEL maintainer="Johann Zehner <hans[at]dcms.at>"
LABEL firebirdversion="3.0.7"

ARG FBDOWNLOAD=https://github.com/FirebirdSQL/firebird/releases/download/R3_0_7/Firebird-3.0.7.33374-0.amd64.tar.gz
ARG SYSDBAPASSWORD=masterkey
ARG FBPORT=3050
ARG AUXPORT=3051
ARG TMPBLKSZE=1M
ARG TMPCHLIMIT=64M
ARG SERVERMD=Super
ARG WIRECR=Disabled
ARG AUTHSRV=Legacy_Auth
ARG AUTHCL=Legacy_Auth
ARG USERMGR=Legacy_UserManager

ENV SYSDBAPASS=${SYSDBAPASSWORD}
ENV FIREBIRD_PORT=${FBPORT}
ENV REMOTE_AUX_PORT=${AUXPORT}
ENV TMPBLOCKSIZE=${TMPBLKSZE}
ENV TMPCACHELIMIT=${TMPCHLIMIT}
ENV SERVERMODE=${SERVERMD}
ENV WIRECRYPT=${WIRECR}
ENV AUTHSERVER=${AUTHSRV}
ENV AUTHCLIENT=${AUTHCL}
ENV USERMANAGER=${USERMGR}

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
    chmod +x /startup.sh

VOLUME /db

CMD [ "/startup.sh" ]
