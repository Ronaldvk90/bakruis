FROM alpine:3.21
RUN apk update && apk upgrade
RUN apk add --no-cache avahi
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
CMD ["/entrypoint.sh"]