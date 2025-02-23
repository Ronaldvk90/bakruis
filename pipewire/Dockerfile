FROM alpine:3.21
RUN apk update && apk upgrade
RUN apk -U add pipewire wireplumber pipewire-spa-bluez
RUN adduser -D --uid 1000 bakruis
RUN cp -a /usr/share/pipewire /etc
RUN cp -a /usr/share/wireplumber /etc
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
