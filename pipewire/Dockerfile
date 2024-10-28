FROM alpine:3.20
RUN apk update && apk upgrade
RUN apk -U add pipewire pipewire-pulse pipewire-zeroconf tzdata
RUN adduser -D --uid 1000 bakruis
RUN mkdir /etc/pipewire
COPY pipewire.conf /etc/pipewire/pipewire.conf
RUN cp -a /usr/share/wireplumber /etc
COPY 50-wireplumber-disable-dbus.conf /etc/wireplumber/wireplumber.conf.d/50-wireplumber-disable-dbus.conf
COPY 51-disable-suspension.conf /etc/wireplumber/wireplumber.conf.d/51-disable-suspension.conf

# Edit the group ID below if needed.
RUN addgroup -g 29 pipewire_audio && addgroup bakruis pipewire_audio
#

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
