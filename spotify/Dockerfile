# Preparing the container to build spotifyd
FROM debian:bookworm AS buildcontainer

# Preparing files and the spotifyd sourcecode
RUN apt update && apt upgrade -y
RUN apt install tzdata dbus git pkg-config libasound2-dev pulseaudio gcc cmake clang libclang-dev curl -y
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN /root/.cargo/bin/rustup default nightly
RUN git clone https://github.com/Spotifyd/spotifyd.git

# Building spotifyd
WORKDIR /spotifyd
RUN /root/.cargo/bin/cargo build --release --features "pulseaudio_backend"

# Live container
FROM debian:bookworm
RUN apt update && apt upgrade -y
RUN apt install libasound2-dev pulseaudio -y
RUN adduser --uid 1000 bakruis
COPY spotifyd.conf /etc/spotifyd.conf
COPY --from=buildcontainer /spotifyd/target/release/spotifyd /usr/bin/spotifyd
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep spotifyd > /dev/null || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]
