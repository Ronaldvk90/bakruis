FROM alpine:3.20
RUN apk -U add pipewire pipewire-pulse pipewire-alsa pipewire-zeroconf tzdata
RUN adduser -D --uid 1000 bakruis
RUN mkdir /etc/pipewire
COPY pipewire.conf /etc/pipewire/pipewire.conf
COPY pipewire-pulse.conf /etc/pipewire/pipewire-pulse.conf
RUN cp -a /usr/share/wireplumber /etc
COPY wireplumber.conf /etc/wireplumber/wireplumber.conf.d/wireplumber.conf

# Edit the group ID below if needed.
RUN addgroup -g 29 pipewire_audio && addgroup bakruis pipewire_audio
#

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]