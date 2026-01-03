FROM alpine:3.23
RUN apk update && apk upgrade
RUN apk -U add pulseaudio pulseaudio-alsa pulseaudio-zeroconf pulseaudio-utils
RUN adduser -D --uid 1000 bakruis
COPY entrypoint.sh /
#COPY sinkvolume /usr/local/bin/sinkvolume
#RUN chmod +x /usr/local/bin/sinkvolume
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep pulseaudio > /dev/null || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]
