FROM alpine:3.24
RUN apk -U add bluez tzdata util-linux
COPY main.conf /etc/bluetooth/main.conf
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep bluetoothd > /dev/null || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]
