# Welcome to bakruis! A spotify/pipewire/Airplay2 docker instance.

First of all, I would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.

I could not have built this without this awesome person! :)
I forked his container to be compatible with my avahi and dbus container. His original one runs both inside.

**You might want to disable avahi on the host. Sometimes it works, sometimes it won't... Don't know why tbh...**
Edit the .env file to suit your output

In the pipewire container, it will make a dedicated audio group. **The default RaspberryPi OS group is 29.** It should correspond to that. If somehow your audio group number differs because you're using a different OS, change the **AUDIO_GROUP** variable. **"getent group | grep audio" should do the trick.**


* You can set the advertising names for the container in the compose file. The hostname for each container will correspond with how it advertises itself. *

**Note! In the env file, you need to set the ALIAS variable to set your BT name**
After that, just compose up and you are good to go.
