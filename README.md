# Welcome to bakruis! A spotify/pipewire/Airplay2 docker instance.

Please note! PipeWire over TCP is still work in progress! ;-)

First of all, i would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.

I could not have build this without this awesome person! :)

Edit the environment file to suit you. You can set your timezone there. Alsa you can set the output device here. In most cases it will be **"hw:0"**. This corresponds to the first audio device on a RPI for example. If you would like to use a USB audio device, for example change it to **"hw:1"**.

for shairport-sync, you need the supplied shairport-sync.conf because of the pulse socket.

In the Dockerfile in the pipe container, it will make a pulse_audio group. **The default RaspberryPi OS group is 29**. It should correspond to that. If somehow your audio group number differs, change that line. "getent group | grep audio" should do the trick.
Do the same for the Spotify Dockerfile.

* You might want to edit the name of your shairport-sync container. The default is the hostname of the Docker host.
* You might also want to edit the name of the spotify connect container. This can be done in the spotifyd.conf file in the spotify container. The default is "bakruis".

**WARNING! It takes about 500 years for SpotifyD to compile. You could crosscompile it, but make sure to use the "--features "pulseaudio_backend" or else SpotifyD can't connect to the Pulse socket!**

After that, just compose up and you are good to go.
