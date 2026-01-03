FROM alpine:3.23
RUN apk update && apk upgrade
RUN apk add --no-cache avahi tzdata
RUN rm /etc/avahi/services/*.service
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD test -S /var/run/avahi-daemon/socket || exit 1
CMD ["/entrypoint.sh"]
