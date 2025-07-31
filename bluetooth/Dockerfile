FROM alpine:3.22
RUN apk update && apk upgrade
RUN apk -U add bluez build-base dbus-dev libffi-dev gcc musl-dev python3-dev py3-gobject3 cairo-dev gobject-introspection-dev pkgconfig python3 py3-dbus py3-pip tzdata
RUN wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.9.tar.gz
RUN tar xvfz bluez-5.9.tar.gz
WORKDIR /bluez-5.9
RUN python3 -m venv /root/venv
RUN . /root/venv/bin/activate && pip install --upgrade pip && pip install pydbus pygobject dbus-python
COPY main.conf /etc/bluetooth/main.conf
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=10 CMD pgrep bluetoothd > /dev/null || exit 1
ENTRYPOINT [ "/entrypoint.sh" ]