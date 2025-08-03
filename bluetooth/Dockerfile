FROM alpine:3.22
RUN apk update && apk upgrade
RUN apk -U add bluez tzdata expect
COPY main.conf /etc/bluetooth/main.conf
COPY bluetoothaccept /usr/local/bin/bluetoothaccept
RUN chmod +x /usr/local/bin/bluetoothaccept
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep bluetoothd > /dev/null || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]
