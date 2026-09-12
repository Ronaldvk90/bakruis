# Welcome to bakruis! A PulseaudioTCP/Spotify/Airplay2/Bluetooth A2DP docker instance.

1)
First of all, I would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.\
I could not have built this without his work! :)\
I forked his container becouse Mike's origional shairport container denied connecting to a pulse socket as user.\
\
Just copy the .env.example to .env and set the variables accordingly.\
\
The audio group in the env file must correspond to the audio group on your machine.\
The next vars to set are the name, output device and TimeZone.\
\
The list of output decvices can be achieved by running **docker exec -it bakruis-pulseaudio-1 pactl list sinks short**.\
\
Just copy the output name only. For example: **alsa_output.platform-3f00b840.mailbox.stereo-fallback**.\
\
Restart the container with **docker restart bakruis-pulseaudio-1** and you're up and running!\
\
2)
Be absolutely **SURE** bluetoothd is NOT running on the host (if you are going to use BT. You could comment out the container if you are not planning to use BT).\
You can most likely disable it by running *sudo systemctl disable bluetooth --now*. This is becouse for BT to work, i need to have a private dbus session in the container.\
You also need to **unblock the BT device**. For this you run *sudo rfkill unblock bluetooth* on the host, not in the container.\
\
The same goes for avahi-daemon! *sudo systemctl disable avahi --now*\
\
due to BT s*cks in containers, you have to manually add and trust your devices in the bluetoothctl commandline in the container.\
\
For that:\
**docker exec -it bakruis-bluetooth-1 sh** gives you a shell in the BT container\
**bluetoothctl** (Starts the BT commandline tools)\
**power on** (Starts the BT device if that isn't done automaticaly)\
**discoverable yes** (Sets this device to be discoverable to other devices)\
**pairable yes** (Sets this device to be pairable with other devices)\
\
Than just let your device search for a bluetooth device with the name you typed earlier in your .env.\
Pair the device and when asked, type yes one or more times to let your client connect in the containers BT console. be SURE to also trust the device after you added it with **trust \<device mac addr\> (without the brackets)** in the console.\
This because it will than autoconnect without the console hassle next time.\
Usualy a bash on the tab key does wonders! ;-)\
Exit out, and done!\
\
**ADDING YOUR OWN SERVICE *DRUMROLL***\
\
If you want to add a service to bakruis, feel free!\
\
Add your service in the compose file, and load the .env file in your container:\
\
The needed environments in the .env file:\
DBUS_SYSTEM_BUS_ADDRESS=unix:path=/var/run/dbus/system_bus_socket\
DBUS_SESSION_BUS_ADDRESS=unix:path=/var/run/dbus/session_bus_socket\
PULSE_SERVER=tcp:172.31.0.3:4713\
\
You can use both DBUS addresses. They both come from the same container.\
This will connect the service to avahi trough DBUS and the pulseaudio container trough DBUS socket and puleaudio TCP socket.