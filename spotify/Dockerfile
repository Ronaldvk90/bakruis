FROM alpine:3.21 AS buildcontainer

ENV PATH="/root/.cargo/bin:$PATH"
ENV RUSTFLAGS="-C target-feature=-crt-static"

RUN apk update && apk upgrade
RUN apk -U add tzdata rustup dbus git pkgconfig alsa-lib-dev pulseaudio gcc musl-dev
RUN rustup-init  --default-toolchain nightly -y
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
