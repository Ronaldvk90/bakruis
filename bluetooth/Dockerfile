FROM alpine:3.21
RUN apk update && apk upgrade
RUN apk -U add bluez

COPY main.conf /etc/bluetooth/main.conf
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]