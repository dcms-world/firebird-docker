FROM debian:9.13-slim

LABEL maintainer="Hans Zehner <hans[at]dcms.at>"
LABEL firebirdversion="2.5.9 CS"

ARG FBDOWNLOAD=https://github.com/FirebirdSQL/firebird/releases/download/R2_5_9/FirebirdCS-2.5.9.27139-0.amd64.tar.gz
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
	ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
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

RUN echo "### Configuration added by startup.sh ###" > /opt/firebird/firebird.conf

VOLUME /db

CMD [ "/startup.sh" ]
