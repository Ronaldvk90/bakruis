ARG NQPTP_BRANCH=main
ARG SHAIRPORT_SYNC_BRANCH=main
#ARG SHAIRPORT_SYNC_BRANCH=.

FROM alpine:3.20 AS builder

RUN apk -U add \
        alsa-lib-dev \
        autoconf \
        automake \
        avahi-dev \
        build-base \
        dbus \
        ffmpeg-dev \
        git \
        libconfig-dev \
        libgcrypt-dev \
        libplist-dev \
        libressl-dev \
        libsndfile-dev \
        libsodium-dev \
        libtool \
        pipewire-dev \
        mosquitto-dev \
        popt-dev \
        pulseaudio-dev \
        soxr-dev \
        xxd \
        tzdata

##### ALAC #####
FROM builder AS alac
RUN git clone --depth=1 https://github.com/mikebrady/alac
WORKDIR /alac
RUN autoreconf -i
RUN ./configure
RUN make -j $(nproc)
RUN make install
WORKDIR /
##### ALAC END #####

##### NQPTP #####
FROM builder AS nqptp
ARG NQPTP_BRANCH
RUN git clone --depth=1 -b "$NQPTP_BRANCH" https://github.com/mikebrady/nqptp
WORKDIR /nqptp
RUN autoreconf -i
RUN ./configure
RUN make -j $(nproc)
WORKDIR /
##### NQPTP END #####

##### SPS #####
# Note: apple-alac requires alac build first.
FROM alac AS shairport-sync
RUN git clone https://github.com/mikebrady/shairport-sync
WORKDIR /shairport-sync/build
RUN autoreconf -i ../
RUN CFLAGS="-O3" CXXFLAGS="-O3" ../configure --sysconfdir=/etc --with-alsa --with-pa --with-soxr --with-avahi --with-ssl=openssl \
        --with-airplay-2 --with-metadata --with-dummy --with-pipe --with-dbus-interface \
        --with-stdout --with-mpris-interface --with-mqtt-client \
        --with-apple-alac --with-convolution --with-pw
RUN make -j $(nproc)
RUN DESTDIR=install make install
WORKDIR /
##### SPS END #####

##### BUILD FILES #####
FROM alpine:3.20

RUN apk -U add \
        alsa-lib \
        ffmpeg \
        glib \
        less \
        less-doc \
        libconfig \
        libgcrypt \
        libplist \
        libpulse \
        libressl3.8-libcrypto \
        libsndfile \
        libsodium \
        libuuid \
        pipewire \
        man-pages \
        mandoc \
        mosquitto \
        popt \
        soxr \
        curl

RUN rm -rfv /lib/apk/db/* && \
        addgroup shairport-sync && \
        adduser -D -u 1002 shairport-sync -G shairport-sync && \
        addgroup -g 29 docker_audio && \
        addgroup shairport-sync docker_audio && \
        addgroup shairport-sync audio

COPY --from=shairport-sync /shairport-sync/build/install/usr/local/bin/shairport-sync /usr/local/bin/shairport-sync
COPY --from=shairport-sync /shairport-sync/build/install/usr/local/share/man/man1 /usr/share/man/man1
COPY --from=nqptp /nqptp/nqptp /usr/local/bin/nqptp
COPY --from=alac /usr/local/lib/libalac.* /usr/local/lib/
COPY --from=shairport-sync /shairport-sync/build/install/etc/shairport-sync.conf.sample /etc/

COPY shairport-sync.conf /etc/
COPY run.sh /
RUN chmod +x /run.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep shairport-sync > /dev/null || exit 1

ENTRYPOINT ["./run.sh"]