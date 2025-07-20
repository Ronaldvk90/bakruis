#!/usr/bin/env bash

# Clear screen
clear

#Check if Dialog is installed
if ! command -v dialog 2>&1 >/dev/null
then

# If not, i will try to install it for you for different OS's
PS3="It looks like you don't have dialog installed. Would you like me to try installing it for you? Type 1 or 2: "
options=("yes" "no") 
select opt in "${options[@]}" 
do 
case $opt in 
"no") 
echo "The setup cannot continue, will terminate now."
exit
;;

"yes")
printf "Trying to determine your OS....\n\n"
    OS=$(grep -E '^(ID)=' /etc/os-release)
        
        if [[ "$OS" == *bian* ]]; then
          echo "Found Debian/Ubuntu/Mint/RaspberryPiOS! Installing Dialog..."
          sudo apt install -y dialog
          break
        continue
        fi
        
        if [[ "$OS" == *rhel* ]]; then
            echo "Found RedHat/CentOS/Fedora/AlmaLinux/Rockylinux. Installing Dialog..."
            sudo dnf install -y dialog
            break
        continue
        fi

        if [[ "$OS" == *suse* ]]; then
            echo "Found SLE/OpenSUSE. Installing Dialog..."
            sudo zypper in -y dialog
            break
        continue
        fi

        if [[ "$OS" == *arch* ]]; then
            echo "Found Arch/Manjaro. Installing Dialog..."
            sudo pacman -Syu dialog
            break
        continue
        fi

        if [[ "$OS" == * ]]; then
            echo "OS is not supported. It MIGHT work if you install dialog manually..."
            exit
        continue
        fi
;;
*) 
echo "Invalid option $REPLY" 
;; 
esac
done
fi
# Clear screen
clear

#Check if a .env is in place. If not, a firstrun will start. If so, a setup menu will appear.
if [ -f ./.env ]; then

# Set the audio group by forehand! Or else no output can be set in the menu.
AUDIOGROUP=$(getent group audio | cut -d: -f3)
sed -i '/AUDIO_GROUP=/c\AUDIO_GROUP='$AUDIOGROUP'' .env

# Source the variables of the env file.
set -a && source ./.env && set +a

# Start the containers so changes can go live.
echo -e "\033[31m(Re)starting containers!\e[0m" 
docker compose up -d

else
# Copy the example env file to .env.
cp .env.example .env

# Set the audio group by forehand! Or else no output can be set in the menu.
AUDIOGROUP=$(getent group audio | cut -d: -f3)
sed -i '/AUDIO_GROUP=/c\AUDIO_GROUP='$AUDIOGROUP'' .env

# Start the containers so changes can go live.
echo -e "\033[31m(Re)starting containers!\e[0m" 
docker compose up -d
fi


# Source the variables of the env file.
set -a && source ./.env && set +a

# Creating the dialog manu.
HEIGHT=15
WIDTH=100
CHOICE_HEIGHT=4
BACKTITLE="Bakruis setup menu 1.0"
TITLE="What would you like to change?"
MENU="Choose one of the following options:"

OPTIONS=(1 "Advertisement name:     current: $NAME"
         2 "Audio Device:           Current: $DEVICE"
         3 "Audio Group:            Current: $AUDIO_GROUP"
         4 "TimeZone:               Current: $TZ"
         5 "Exit Setup                                   ")

AUDIOOPTIONS=(1 "Auto detect audio group (recommended)"
              2 "Manual set audio group  Current: $AUDIO_GROUP")


# Some complex stuff. I'm pulling the actual audio devices from the container, and packing them in a array for the choice menu.
while true ; do
    SETDEVICE=$(docker exec -i -u 1000 bakruis-pipewire-pulse-1 pactl list sinks short | awk '{print $2}'| sort | cat -n | grep '^' | cut -c8-)
        if [[ ! -z "$SETDEVICE" ]] ; then
        echo "$SETDEVICE"
        break
    fi
done
IFS=$'\n' read -rd '' -a DEVICES <<< "$SETDEVICE"


DEVICEOPTIONS=()
for i in "${!DEVICES[@]}"; do
    DEVICEOPTIONS+=("$((i + 1))" "${DEVICES[$i]}")
done

while [ "$CHOICE -ne 4" ]; do 
    CHOICE=$(dialog --clear \
                --nocancel \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                --keep-tite \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
    clear
    case $CHOICE in
        1)
            NAME=$(dialog --inputbox "Enter new Advertisement name: " 0 100 --output-fd 1)
            sed -i '/NAME=/c\NAME='$NAME'' .env
            ;;
        2)
            DEVICE=$(dialog --clear --stdout \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                --keep-tite \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
               "${DEVICEOPTIONS[@]}" \
                2>&1 >/dev/tty)
            
            case $DEVICE in
                *)
                sed -i "s|^DEVICE=.*|DEVICE=${DEVICES[$((DEVICE - 1))]}|" .env
                ;;
            esac

  
            ;;
        3)
            AUDIOCHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                --keep-tite \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${AUDIOOPTIONS[@]}" \
                2>&1 >/dev/tty)
            case $AUDIOCHOICE in
                1)
                AUDIOGROUP=$(getent group audio | cut -d: -f3)
                sed -i '/AUDIO_GROUP=/c\AUDIO_GROUP='$AUDIOGROUP'' .env
                    ;;
                2)
                AUDIOGROUP=$(dialog --inputbox "Enter new GroupID: " 0 100 --output-fd 1)
                sed -i '/AUDIO_GROUP=/c\AUDIO_GROUP='$AUDIOGROUP'' .env
                    ;;
                esac
            ;;

        4)  TZ=$(dialog --inputbox "Enter Timezone: " 0 100 --output-fd 1)
            sed -i '/TZ=/c\TZ='$TZ'' .env
            ;;
        5)
            exit
            ;;
    esac
exec /bin/bash "$0" "$@"
done
