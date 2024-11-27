# Welcome to bakruis pulseaudio! A spotify/pulseaudio/Airplay2 docker instance.

First of all, I would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.
I could not have built this without this awesome person! :)

This is the pulseaudio branch of bakruis, *intended to be used on a RPI*.
Audio device switching with Pipewire is a hellish nightmare on a Pi from my perception. Tho it has probably everything to do with my incompetence. :)

Edit the .env environment file to suit you.

You can also set the output device there. This is the **DEVICE** variable. Default it will be blank. This corresponds to the  audio device you want to use. If you would like to use a USB audio device, for example change it so you don't have to blacklist any modules and stick your dirty fingers in alsa on the host. :P

If the pulseaudio container runs, simply type **docker exec -u 1000 bakruis-pulseaudio-$ContainerNumber pactl list sinks short**, where the container number could differ per setup. In most cases it will be just **bakruis-pulseaudio-1**.

This will create a list of audio devices available. For example in my case it is:\
0	alsa_output.platform-bcm2835_audio.stereo-fallback\
1	alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo

In my case i eddited the .env file device line like this: **DEVICE=alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo**.
After that, rebuild the container and the default device should work!

for shairport-sync, you need the supplied shairport-sync.conf because it needs to connect to the pulse socket. It will be done automaticaly in the compose file.

In the Dockerfile of the pulseaudio container, it will make a dedicated audio group. **The default RaspberryPi OS group is 29**. It should correspond to that. If somehow your audio group number differs because you're using a different OS, change that line. **"getent group | grep audio" should do the trick.**

*You can set the advertising names for the container in the compose file. The hostname for each container will correspond with how it advertises itself.*

After that, just compose up and you are good to go.
