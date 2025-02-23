# Welcome to bakruis pulseaudio! A spotify/pipewire/Airplay2/Bluetooth A2DP docker instance.

1)
First of all, I would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.
I could not have built this without this awesome person! :)

I forked his container becouse i could not run 2 avahi instances at once. Mike runs avahi inside his container, and i run a avahi container for pulseaudio TCP. 

This is the pipewire branch of bakruis, *Still in active development!*.
Audio device switching with Pipewire is a hellish nightmare on a Pi from my perception. Tho it has probably everything to do with my incompetence. :)

2)
Be absolutely **SURE** bluetoothd is NOT running on the host. You can most likely disable it by running *systemctl disable bluetooth --now*. This is becouse for BT to work, i need to have a private dbus session in the container.

The same goes for avahi-daemon! Same principle. :)

Edit the .env environment file to suit you.

In the pipewire container, it will make a dedicated audio group. **The default RaspberryPi OS group is 29**. It should correspond to that. If somehow your audio group number differs because you're using a different OS, change the **AUDIO_GROUP** variable. **"getent group | grep audio" should do the trick.**

We also have to set our BT name! The **ALIAS** variable does that trick.
If you're not planning to use BT, just comment out the container in the compose file.

When the container runs, we have to enter it from the commandline if we want to pair and trust a device. No worry's it only has to be done once per device you'd like to connect! :) This becouse of security and my own incompetence.

**docker exec -it -u 1000 bakruis-bluetooth-1 /bin/sh**

*bluetoothctl*
*discoverable yes* (sometimes it just won't be visable out of the box, and sometimes it is...)

The connect your device, pair. and finaly when that's done, type:

*trust <BT CLIENT DEVICE MAC ADRESS>* (usualy autofills with the TAB key ;-) )

And Bob's your uncle! Happy streaming! :D

3)
*You can set the advertising names for the container in the compose file. The hostname for each container will correspond with how it advertises itself.*

After that, just compose up and you are good to go.
