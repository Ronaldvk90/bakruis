FROM alpine:3.20
RUN apk -U add pipewire pipewire-pulse pipewire-zeroconf tzdata
RUN adduser -D --uid 1000 bakruis
RUN mkdir /etc/pipewire
COPY pipewire-pulse.conf /etc/pipewire/pipewire-pulse.conf

# Edit the group ID below if needed.
RUN addgroup -g 29 pipewire_audio && addgroup bakruis pipewire_audio
#

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
