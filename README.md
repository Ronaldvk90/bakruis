# Welcome to bakruis! A spotify/pulseaudio/Airplay2 docker instance.

First of all, i would like to thank Mike Brady for his work with Airplay. I use his Shairport-sync docker instance.
Second i want to thank Reichley for his awesome work on Raspotify! This project uses his container.

I could not have build this without these two awesome persons! :)

Edit the compose file to suit you. You can set your timezone there. Needed for the audio timing in the pulse container.
Just compose up and you are good to go. You might want to supply your own shairport-sync config file. It's commented out. But easy to do.
Furthermore, if you would like to use spotify connect, simply edit the hostname in the compose file if you desire.