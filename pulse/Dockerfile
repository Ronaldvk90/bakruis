FROM alpine:3.19

RUN apk -U add pulseaudio pulseaudio-zeroconf avahi dbus tzdata
RUN adduser -D --uid 1000 bakruis
RUN echo -e "load-module module-native-protocol-tcp auth-anonymous=1\nload-module module-zeroconf-publish\nload-module module-alsa-sink device=hw:0 sink_name=bakruis\nload-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/pulseaudio.socket" >> /etc/pulse/default.pa
RUN sed -i '/module-suspend-on-idle/c #load-module module-suspend-on-idle' /etc/pulse/default.pa
RUN sed -i '/audio/c audio:x:29:pulse,bakruis' /etc/group
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
