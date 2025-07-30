# Preparing the container to build spotifyd
FROM debian:bookworm AS buildcontainer

# Preparing files and the spotifyd sourcecode
RUN apt update && apt upgrade -y
RUN apt install tzdata git curl gcc libpulse-dev libasound2-dev -y
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN git clone https://github.com/librespot-org/librespot.git

# Building spotifyd
WORKDIR /librespot
RUN /root/.cargo/bin/cargo build --release --features "pulseaudio-backend"

# Live container
FROM debian:bookworm-slim
RUN apt update && apt upgrade -y
RUN apt install tzdata procps pulseaudio -y
RUN adduser --uid 1000 bakruis
COPY --from=buildcontainer /librespot/target/release/librespot /usr/bin/librespot
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep librespot > /dev/null || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]
