# Welcome to bakruis! A spotify/pulseaudio/Airplay2 docker instance.

First of all, i would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.
Second i want to thank Reichley for his awesome work on Raspotify! This project uses his container.

I could not have build this without these two awesome persons! :)

Edit the compose file to suit you. You can set your timezone there. Needed for the audio timing in the pulse container.

for shairport-sync, you need the supplied shairport-sync.conf because of the pulse socket.

In the default.pa of the pulse container, it will output to "hw:0". If you have multiple sound devices, and want to output on a different one, just change that line.
In the Dockerfile in the pulse container, it will make a pulse_audio group. The default RaspberryPi OS group is 29. It should correspond to that. If somehow your audio group number differs, change that line. "getent group | grep audio" should do the trick.

You might want to edit the name of your shairport-sync device. After that, just compose up and you are good to go.
Furthermore, if you would like to use spotify connect, simply edit the hostname in the compose file if you desire.
