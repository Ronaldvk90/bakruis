FROM alpine:3.20
RUN apk -U add avahi
COPY avahi-daemon.conf /etc/avahi/avahi-daemon.conf
COPY pulseaudio.service /etc/avahi/services/pulseaudio.service
COPY run.sh run.sh
RUN chmod +x run.sh
ENTRYPOINT [ "/run.sh" ]
