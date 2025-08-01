FROM alpine:3.22
RUN apk update && apk upgrade
RUN apk -U add pipewire pipewire-spa-bluez pipewire-pulse pipewire-zeroconf wireplumber eudev tzdata
RUN adduser -D --uid 1000 bakruis
RUN cp -a /usr/share/pipewire /etc
RUN cp -a /usr/share/wireplumber /etc
COPY entrypoint.sh /
COPY sinkvolume /usr/local/bin/sinkvolume
RUN chmod +x /usr/local/bin/sinkvolume
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD test -S /tmp/pipewire-0 || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]