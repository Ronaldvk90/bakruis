FROM alpine:3.20
RUN apk -U add pipewire pipewire-pulse pipewire-zeroconf tzdata
RUN adduser -D --uid 1000 bakruis
RUN mkdir /etc/pipewire
COPY pipewire-pulse.conf /etc/pipewire/pipewire-pulse.conf
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
