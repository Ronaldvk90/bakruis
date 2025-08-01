# Welcome to bakruis! A spotify/pipewire/Airplay2/Bluetooth A2DP docker instance.

1)
First of all, I would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.
I could not have built this without this awesome person! :)

I forked his container becouse i could not run 2 avahi instances at once. Mike runs avahi inside his container, and i run a avahi container for pulseaudio TCP. 

Just run **run.sh** and you will be guided trough the setup.

The audio group will be set automaticaly correspondingly
The only thing to actualy do is set the name, output device via a menu and TimeZone.

2)
Be absolutely **SURE** bluetoothd is NOT running on the host. You can most likely disable it by running *systemctl disable bluetooth --now*. This is becouse for BT to work, i need to have a private dbus session in the container.

The same goes for avahi-daemon! Same principle. :)

When the container runs, we have to enter it from the commandline if we want to pair and trust a device. No worry's it only has to be done once per device you'd like to connect! :) This becouse of security and my own incompetence.

**ADDING YOUR OWN SERVICE *DRUMROLL***

If you want to add a service to bakruis, feel free!

Add your service in the compose file, and load the .env file in your container. 
Make sure in the composefile to mount the *sockets* volume to /tmp/
The needed environments in the .env file:

DBUS_SYSTEM_BUS_ADDRESS=unix:path=/tmp/system_bus_socket
PULSE_SERVER=unix:/tmp/pulseaudio.socket

Or use PipeWire at **/tmp/pipewire-0**

This will connect the service to avahi trough DBUS and the PipeWire-Pulse container trough DBUS socket and PipeWire-Pulse or pipewire socket.