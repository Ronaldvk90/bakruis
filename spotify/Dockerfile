FROM alpine:3.23
RUN apk add --no-cache spotifyd
COPY entrypoint.sh /
COPY spotifyd.conf /
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep spotifyd > /dev/null || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]
