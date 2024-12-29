# Welcome to bakruis! A spotify/pipewire/Airplay2 docker instance.

First of all, I would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.

I could not have built this without this awesome person! :)

**You need avahi-daemon and dbus running on the host!** Most distro's come standard with both enabled tho. :)

Edit the .env file to suit your output

In the pulseaudio container, it will make a dedicated audio group. **The default RaspberryPi OS group is 29.** It should correspond to that. If somehow your audio group number differs because you're using a different OS, change the **AUDIO_GROUP** variable. **"getent group | grep audio" should do the trick.**

You can set the output **device.** In most cases it will be **"hw:0"**. This corresponds to the first audio device on a RPI for example. If you would like to use a USB audio device, for example change it to **"hw:1"** so you don't have to blacklist and modules and stick your dirty fingers in alsa. :P

for shairport-sync, you need the supplied shairport-sync.conf because it needs to connect to the pulse socket.

* You can set the advertising names for the container in the compose file. The hostname for each container will correspond with how it advertises itself. *
After that, just compose up and you are good to go.
