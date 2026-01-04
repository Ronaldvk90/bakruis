FROM alpine:3.23
RUN apk update && apk upgrade
RUN apk -U add pulseaudio pulseaudio-alsa pulseaudio-zeroconf pulseaudio-utils pulseaudio-bluez
RUN adduser -D --uid 1000 bakruis
COPY sinkvolume.sh /
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN chmod +x /sinkvolume.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep pulseaudio > /dev/null || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]
