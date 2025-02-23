FROM alpine:3.21
RUN apk update && apk upgrade
RUN apk -U add pipewire-pulse pipewire-zeroconf
RUN adduser -D --uid 1000 bakruis
RUN mkdir /etc/pipewire
COPY pipewire-pulse.conf /etc/pipewire/pipewire-pulse.conf
USER bakruis
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD test -S /tmp/pulseaudio.socket || exit 1
ENTRYPOINT [ "pipewire-pulse" ]
