FROM alpine:3.20 as buildcontainer
RUN apk -U add tzdata dbus cargo git pkgconfig alsa-lib-dev pulseaudio
RUN git clone https://github.com/Spotifyd/spotifyd.git
WORKDIR /spotifyd
RUN cargo build --release --features "pulseaudio_backend"

FROM alpine:3.20
RUN apk -U add alsa-lib-dev pulseaudio
RUN adduser -D --uid 1000 bakruis
COPY spotifyd.conf /etc/spotifyd.conf
COPY --from=buildcontainer /spotifyd/target/release/spotifyd /usr/bin/spotifyd

# Edit the group ID below if needed.
RUN addgroup -g 29 spotify_audio && addgroup bakruis spotify_audio
#

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]