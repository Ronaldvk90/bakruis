FROM alpine:3.21
RUN apk update && apk upgrade
RUN apk add --no-cache dbus
COPY system.conf /usr/share/dbus-1/system.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD test -S /var/run/dbus/system_bus_socket || exit 1
ENTRYPOINT ["/entrypoint.sh"]
