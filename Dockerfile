FROM debian:9.4-slim

LABEL maintainer="Hans Zehner <hans[at]dcms.at>"
LABEL firebirdversion="3.0.4"

ARG FBDOWNLOAD=https://github.com/FirebirdSQL/firebird/releases/download/R3_0_4/Firebird-3.0.4.33054-0.amd64.tar.gz
ARG SYSDBAPASSWORD=masterkey
ENV SYSDBAPASS=${SYSDBAPASSWORD}

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
    echo "DatabaseAccess = Full" >> /opt/firebird/firebird.conf && \ 
    echo "ServerMode = SuperClassic" >>/opt/firebird/firebird.conf && \ 
    echo "WireCrypt = Enabled" >>/opt/firebird/firebird.conf && \ 
    echo "AuthServer = Legacy_Auth, Srp, Win_Sspi" >> /opt/firebird/firebird.conf && \ 
    echo "UserManager = Legacy_UserManager, Srp" >>/opt/firebird/firebird.conf


VOLUME /db

EXPOSE 3050/tcp

CMD [ "/startup.sh" ]
