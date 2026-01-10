# Welcome to bakruis! A PulseaudioTCP/Airplay2/Bluetooth A2DP docker instance.

1)
First of all, I would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.
I could not have built this without this awesome person! :)

I forked his container becouse i could not run 2 avahi instances at once. Mike runs avahi inside his container, and i run a avahi container for pulseaudio TCP. 

Just run **run.sh** and you will be guided trough the setup.

The audio group in the env file must correspond to the audio group on your machine.

The audio group will be set automaticaly correspondingly if *run.sh* is executed. It will detect the group on your machine.
The only thing to actualy do is set the name, output device and TimeZone in the menu.

2)
Be absolutely **SURE** bluetoothd is NOT running on the host (if you are going to use BT. You could comment out the container if you are not planning to use BT).
You can most likely disable it by running *sudo systemctl disable bluetooth --now*. This is becouse for BT to work, i need to have a private dbus session in the container.
You also need to **unblock the BT device**. For this you run *sudo rfkill unblock bluetooth* on the host, not in the container.

The same goes for avahi-daemon! *sudo systemctl disable avahi --now*

due to BT s*cks in containers, i have to work with a expect script to auto "pair and trust" devices. You will be **shown a pin** when you connect, but it will default "yes!" to every question in the bluetoothctl. I still can't get NoInputNoOutput to work. :)

**ADDING YOUR OWN SERVICE *DRUMROLL***

If you want to add a service to bakruis, feel free!

Add your service in the compose file, and load the .env file in your container. 
The needed environments in the .env file:

DBUS_SYSTEM_BUS_ADDRESS=unix:path=/var/run/dbus/system_bus_socket
DBUS_SESSION_BUS_ADDRESS=unix:path=/var/run/dbus/session_bus_socket
PULSE_SERVER=tcp:172.31.0.3:4713

You can use both DBUS addresses. They both come from the same container.

This will connect the service to avahi trough DBUS and the pulseaudio container trough DBUS socket and puleaudio TCP socket.
