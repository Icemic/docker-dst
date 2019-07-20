from debian:stretch
LABEL maintainer="Winston Astrachan"
LABEL description="Don't Starve Together Dedicated Server"

ENV DEPS="lib32gcc1 lib32stdc++6 libcurl4-gnutls-dev:i386"
ENV BUILD_DEPS="wget"
ENV STEAMCMD="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"

VOLUME /dst
EXPOSE 10999/udp
EXPOSE 27016/tcp

RUN \
    mkdir -p /steamcmd /dst/config && \
    adduser --system --home /steam steam && \
    \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -yq $DEPS $BUILD_DEPS && \
    \
    cd /steamcmd && \
    wget -O - "$STEAMCMD" | tar zxvf - && \
    chown -R steam /steam /steamcmd /dst && \
    \
    apt-get purge $BUILD_DEPS --autoremove --purge -yq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN \
    ./steamcmd/steamcmd.sh +login anonymous \
                           +force_install_dir /steam \
                           +app_update 343050 \
                           +exit

COPY /overlay /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/gameserver.sh"]
