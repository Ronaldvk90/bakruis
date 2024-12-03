FROM alpine:3.20
RUN apk update && apk upgrade
RUN apk -U add pipewire pipewire-pulse pipewire-zeroconf
RUN adduser -D --uid 1000 bakruis
RUN mkdir /etc/pipewire
COPY pipewire-pulse.conf /etc/pipewire/pipewire-pulse.conf
USER bakruis
ENTRYPOINT [ "pipewire-pulse" ]
