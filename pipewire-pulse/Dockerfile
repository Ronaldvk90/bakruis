FROM alpine:3.21
RUN apk update && apk upgrade
RUN apk -U add pipewire pipewire-spa-bluez pipewire-pulse pipewire-zeroconf wireplumber
RUN adduser -D --uid 1000 bakruis
RUN cp -a /usr/share/pipewire /etc
RUN cp -a /usr/share/wireplumber /etc
COPY pipewire-pulse.conf /etc/pipewire/pipewire-pulse.conf.d/pipewire-pulse.conf
COPY entrypoint.sh /
COPY sinkvolume.sh /
RUN chmod +x /sinkvolume.sh
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD test -S /tmp/pipewire-0 || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]