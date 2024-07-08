# Welcome to bakruis! A spotify/pipewire/Airplay2 docker instance.

First of all, I would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.

I could not have built this without this awesome person! :)

Edit the environment file to suit you. You can set your timezone there.

You can also set the output device there. In most cases it will be **"hw:0"**. This corresponds to the first audio device on a RPI for example. If you would like to use a USB audio device, for example change it to **"hw:1"** so you don't have to blacklist and modules and stick your dirty fingers in alsa. :P

for shairport-sync, you need the supplied shairport-sync.conf because it needs to connect to the pulse socket.

In the Dockerfile of pipwire, pipewire-pulse and spotify containers, it will make a dedicated audio group. **The default RaspberryPi OS group is 29**. It should correspond to that. If somehow your audio group number differs because you're using a different OS, change that line. Sadly you have to change it for the pipe, pipe-pulse and spotify container. "getent group | grep audio" should do the trick.

* You can set the advertising names for the container in the compose file. The hostname for each container will correspond with how it advertises itself. *

**WARNING! It takes about 500 years for SpotifyD to compile on a RPI. You could crosscompile it, but make sure to use the "--features "pulseaudio_backend" or else SpotifyD can't connect to the Pulse socket!**

After that, just compose up and you are good to go.