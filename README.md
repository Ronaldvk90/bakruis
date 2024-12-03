# Welcome to bakruis! A spotify/pipewire/Airplay2 docker instance.

First of all, I would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.

I could not have built this without this awesome person! :)

** You need avahi-daemon running on the host for pulseaudio over TCP! ** Most distro's come standard with it enabled tho. :)

Edit the .env file to suit your output

You can set the output device. In most cases it will be **"hw:0"**. This corresponds to the first audio device on a RPI for example. If you would like to use a USB audio device, for example change it to **"hw:1"** so you don't have to blacklist and modules and stick your dirty fingers in alsa. :P

for shairport-sync, you need the supplied shairport-sync.conf because it needs to connect to the pulse socket.

In the Dockerfile of the pipwire container, it will make a dedicated audio group. **The default RaspberryPi OS group is 29**. It should correspond to that. If somehow your audio group number differs because you're using a different OS, change that line. **"getent group | grep audio" should do the trick.**

**If you use the image supplied on dockerhub, it will be set to 29! So if your group differs, comment the "image: ronaldvk90/pipewire" line!**

* You can set the advertising names for the container in the compose file. The hostname for each container will correspond with how it advertises itself. *
After that, just compose up and you are good to go.