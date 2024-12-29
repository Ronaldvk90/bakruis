FROM alpine:3.20
RUN apk update && apk upgrade
RUN apk -U add pipewire pipewire-pulse pipewire-zeroconf tzdata
RUN adduser -D --uid 1000 bakruis
RUN mkdir /etc/pipewire
COPY pipewire.conf /etc/pipewire/pipewire.conf
RUN cp -a /usr/share/wireplumber /etc
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
