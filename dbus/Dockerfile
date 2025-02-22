FROM alpine:3.21
RUN apk update && apk upgrade
RUN apk add --no-cache dbus
COPY system.conf /usr/share/dbus-1/system.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
