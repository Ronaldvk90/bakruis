# Welcome to bakruis! A spotify/pulseaudio/Airplay2 docker instance.

First of all, i would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.

I could not have build this without these two awesome person! :)

Edit the compose file to suit you. You can set your timezone there. Needed for the audio timing in the pulse container.

*Please note! The Timezone in the container **MUST** correspond with the timezone of the host. Or else there will be glitches and stuttering all over the place.*

for shairport-sync, you need the supplied shairport-sync.conf because of the pulse socket.

In the default.pa of the pulse container, it will output to **"hw:0"**. If you have multiple sound devices, and want to output on a different one, just change that line.

In the Dockerfile in the pulse container, it will make a pulse_audio group. The default RaspberryPi OS group is 29. It should correspond to that. If somehow your audio group number differs, change that line. "getent group | grep audio" should do the trick.
Do the same for the Spotify Dockerfile.

* You might want to edit the name of your shairport-sync container. The default is the hostname of the Docker host.
* You might also want to edit the name of the spotify connect container. This can be done in the spotifyd.conf file in the spotify container. The default is "bakruis".

**WARNING! It takes about 500 years for SpotifyD to compile. You could crosscompile it, but make sure to use the "--features "pulseaudio_backend" or else SpotifyD can't connect to the Pulse socket!**

After that, just compose up and you are good to go.
Furthermore, if you would like to use spotify connect, simply edit the hostname in the compose file if you desire.
