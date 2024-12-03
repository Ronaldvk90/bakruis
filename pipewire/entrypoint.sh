#!/bin/sh
sed -i "s/\<OUTPUT\>/$OUTPUT/" /etc/pipewire/pipewire.conf
su -c pipewire bakruis