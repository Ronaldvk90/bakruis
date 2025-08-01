FROM debian:bookworm-slim

RUN apt update && apt upgrade -y 
RUN apt install -y pipewire pipewire-pulse libspa-0.2-bluetooth pulseaudio-utils procps
RUN adduser --disabled-password --uid 1000 bakruis
RUN cp -a /usr/share/pipewire /etc
RUN cp -a /usr/share/wireplumber /etc
COPY entrypoint.sh /
COPY sinkvolume /usr/local/bin/sinkvolume
RUN chmod +x /usr/local/bin/sinkvolume
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD test -S /tmp/pipewire-0 || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]
