FROM alpine:3.20

RUN apk update && apk upgrade

RUN apk -U add  pulseaudio\
                pulseaudio-utils\
                pulseaudio-zeroconf

RUN adduser -D --uid 1000 bakruis

# Edit the group ID below if needed.
RUN addgroup -g 29 pulse_audio && addgroup bakruis pulse_audio && addgroup bakruis audio
#
COPY default.pa /etc/pulse/default.pa
COPY daemon.conf /etc/pulse/daemon.conf

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]