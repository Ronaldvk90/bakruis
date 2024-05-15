FROM alpine:3.19
RUN apk -U add pulseaudio pulseaudio-zeroconf avahi dbus tzdata
RUN adduser -D --uid 1000 bakruis
RUN mkdir /etc/pulse/default.pa.d
COPY default.pa /etc/pulse/default.pa.d/default.pa
COPY daemon.conf /etc/pulse/daemon.conf
RUN addgroup -g 29 pulse_audio && addgroup bakruis pulse_audio
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]