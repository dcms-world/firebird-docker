FROM debian:9.4-slim

LABEL maintainer="Hans Zehner <hans[at]dcms.at>"
LABEL firebirdversion="2.5.6"

ARG FBDOWNLOAD=https://sourceforge.net/projects/firebird/files/firebird-linux-amd64/2.5.6-Release/FirebirdCS-2.5.6.27020-0.amd64.tar.gz
ARG SYSDBAPASSWORD=masterkey
ENV SYSDBAPASS=${SYSDBAPASSWORD}

COPY startup.sh /startup.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
         wget \
         procps && \
    rm -rf /var/lib/apt/lists/* && \
    wget --no-check-certificate \
        ${FBDOWNLOAD} \
        -P /root && \
    tar -xvf /root/Firebird*.tar.gz  -C /root/ && \
    cd /root/Firebird* && \
    ./install.sh -silent && \
    ./install.sh -silent && \
    rm -r /root/Firebird* && \
    mkdir /db && \
    chmod +x /startup.sh

VOLUME /db

EXPOSE 3050/tcp

CMD [ "/startup.sh" ]
