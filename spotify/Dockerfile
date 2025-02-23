FROM alpine:3.21 AS buildcontainer
RUN apk update && apk upgrade
RUN apk -U add tzdata dbus cargo git pkgconfig alsa-lib-dev pulseaudio
RUN git clone https://github.com/Spotifyd/spotifyd.git
WORKDIR /spotifyd
RUN cargo build --release --features "pulseaudio_backend"

FROM alpine:3.21
RUN apk update && apk upgrade
RUN apk -U add alsa-lib-dev pulseaudio
RUN adduser -D --uid 1000 bakruis
COPY spotifyd.conf /etc/spotifyd.conf
COPY --from=buildcontainer /spotifyd/target/release/spotifyd /usr/bin/spotifyd
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep spotifyd > /dev/null || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]
