##### FFMPEGLITE #####
FROM alpine:3.24 AS ffmpeglite
RUN apk -U add build-base git nasm pkgconf
RUN mkdir -p /ffmpeg_sources /ffmpeg_build
WORKDIR /ffmpeg_sources
ARG FFMPEG_BRANCH
RUN git clone --depth=1 https://github.com/FFmpeg/FFmpeg
WORKDIR /ffmpeg_sources/FFmpeg
RUN ./configure \
  --prefix="/ffmpeg_build" \
  --extra-libs="-lpthread -lm" \
  --ld="g++" \
  --disable-static \
  --enable-shared \
  --enable-gpl \
  --disable-programs \
  --disable-everything \
  --disable-doc \
  --disable-iconv \
  --disable-avdevice \
  --disable-avfilter \
  --disable-swscale \
  --disable-network \
  --disable-iamf \
  --disable-pixelutils \
  --enable-decoder=alac \
  --enable-decoder=aac
RUN make
RUN make install
##### FFMPEGLITE END #####


##### NQPTP #####
FROM alpine:3.24 AS nqptp
RUN apk -U add \
        musl-dev \
        autoconf \
        automake \
        build-base \
        git \
        linux-headers

ARG NQPTP_BRANCH
RUN git clone --depth=1 https://github.com/mikebrady/nqptp
WORKDIR /nqptp
RUN autoreconf -i
RUN ./configure
RUN make
WORKDIR /
##### NQPTP END #####

##### SPS #####
FROM alpine:3.24 AS shairport-sync
RUN apk -U add \
        pkgconf \
        alsa-lib-dev \
        autoconf \
        automake \
        avahi-dev \
        build-base \
        dbus \
        git \
        libconfig-dev \
        libgcrypt-dev \
        libplist-dev \
        openssl-dev \
        libsndfile-dev \
        libsodium-dev \
        libtool \
        pipewire-dev \
        mosquitto-dev \
        popt-dev \
        pulseaudio-dev \
        soxr-dev \
        libplist-util \
        xxd

COPY --from=ffmpeglite /ffmpeg_build/lib/ /usr/local/lib
COPY --from=ffmpeglite /ffmpeg_build/lib/pkgconfig/*.pc  /usr/local/lib/pkgconfig/
COPY --from=ffmpeglite /ffmpeg_build/include/  /usr/local/include

RUN git clone https://github.com/mikebrady/shairport-sync.git
WORKDIR /shairport-sync
RUN autoreconf -i
RUN ./configure --sysconfdir=/etc --with-alsa --with-pulseaudio --with-soxr --with-avahi --with-ssl=openssl \
        --with-airplay-2 --with-metadata --with-dummy --with-pipe --with-dbus-interface \
        --with-stdout --with-mpris-interface --with-mqtt-client \
        --with-convolution --with-pipewire
RUN make
RUN DESTDIR=install make install
WORKDIR /
##### SPS END #####

# Shairport Sync Runtime System
FROM alpine:3.24
RUN adduser -D --uid 1000 bakruis
RUN apk -U add \
        alsa-lib \
        glib \
        libconfig \
        libgcrypt \
        libplist \
        pipewire \
        libpulse \
        libcrypto3 \
        libsodium \
        libuuid \
        mosquitto \
        popt \
        soxr \
        curl

RUN rm -rfv /lib/apk/db/* && \
        rm -rf /usr/share/man && \
        addgroup shairport-sync && \
        adduser -D shairport-sync -G shairport-sync && \
        addgroup shairport-sync audio

COPY --chmod=755 ./entrypoint.sh /entrypoint.sh
COPY --from=ffmpeglite /ffmpeg_build/lib/ /usr/local/lib
COPY --from=shairport-sync /shairport-sync/install/usr/local/bin/shairport-sync /usr/local/bin/shairport-sync
COPY --from=shairport-sync /shairport-sync/install/usr/local/share/man/man1 /usr/share/man/man1
COPY --from=nqptp /nqptp/nqptp /usr/local/bin/nqptp
COPY --from=shairport-sync /shairport-sync/install/etc/shairport-sync.conf /etc/
COPY --from=shairport-sync /shairport-sync/install/etc/shairport-sync.conf.sample /etc/

HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep shairport-sync > /dev/null || exit 1
ENTRYPOINT ["/entrypoint.sh"]