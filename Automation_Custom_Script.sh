#!/bin/bash
# This script will install Hornet
#The user can put config.json file in the /boot directory which will be copied into the hornet directory
#This file should be installed at: /boot/Automation_Custom_Script.sh
DPIH_BRANCH=`grep -Po '(?<=/dpi_hornet/)([A-Za-z0-9]+)(?=/Automation_Custom_Script.sh)' /boot/dietpi.txt`

COLOUR_RESET='\e[0m'
aCOLOUR=(

		'\e[38;5;154m'  # DietPi green  | Lines, bullets and seperators
		'\e[1m'         # Bold white    | Main descriptions
		'\e[90m'        # Grey          | Credits
		'\e[91m'        # Red           | Update notifications

)
GREEN_LINE=" ${aCOLOUR[0]}─────────────────────────────────────────────────────$COLOUR_RESET"
GREEN_BULLET=" ${aCOLOUR[0]}-$COLOUR_RESET"
GREEN_SEPARATOR="${aCOLOUR[0]}:$COLOUR_RESET"
echo -e ""
echo -e "${aCOLOUR[1]} Installing....$COLOUR_RESET"
echo -e "${GREEN_LINE}"
echo -e "${aCOLOUR[0]} ██╗  ██╗ ██████╗ ██████╗ ███╗   ██╗███████╗████████╗$COLOUR_RESET"
echo -e "${aCOLOUR[0]} ██║  ██║██╔═══██╗██╔══██╗████╗  ██║██╔════╝╚══██╔══╝$COLOUR_RESET"
echo -e "${aCOLOUR[0]} ███████║██║   ██║██████╔╝██╔██╗ ██║█████╗     ██║$COLOUR_RESET"
echo -e "${aCOLOUR[0]} ██╔══██║██║   ██║██╔══██╗██║╚██╗██║██╔══╝     ██║$COLOUR_RESET"
echo -e "${aCOLOUR[0]} ██║  ██║╚██████╔╝██║  ██║██║ ╚████║███████╗   ██║$COLOUR_RESET"
echo -e "${aCOLOUR[0]} ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝$COLOUR_RESET"
echo -e "${GREEN_LINE}"
echo -e "${aCOLOUR[1]}${GREEN_BULLET} IOTA Full Node                             DietPi${GREEN_BULLET} $COLOUR_RESET"
echo -e "${GREEN_LINE}"
echo ""

[[ $DPIH_BRANCH = "master" ]] && BC="${aCOLOUR[1]}" || BC="${aCOLOUR[3]}"
echo -e '\e[90m[\e[0m INFO \e[90m]\e[0m Hornet   | Using Installer Branch ['$BC$DPIH_BRANCH'\e[0m]'

#Update APT to retry 3 times
echo "APT::Acquire::Retries \"3\";" > "/etc/apt/apt.conf.d/80-retries"

apt install -y jq less > /dev/null

if ! [ -x "$(command -v jq)" ]; then
	echo -e '[\e[31mFAILED\e[0m] Hornet   | Failed to Load jq and less. Skipping Hornet installation...'
    exit 1
else
	echo -e '[\e[32m  OK  \e[0m] Hornet   | Installed jq and less.'
fi

#GLOBAL###############################################
HORNET_SRC="/opt/hornet_src"
HORNET_BIN="/opt/hornet"
SERVICE_FILE="/etc/systemd/system/hornet.service"
HORNETUSER=hornet
######################################################
adduser --system --group --no-create-home --quiet $HORNETUSER
mkdir $HORNET_SRC
mkdir $HORNET_BIN
mkdir $HORNET_BIN/config_history

chown -R $HORNETUSER:$HORNETUSER $HORNET_BIN $HORNET_SRC && echo -e '[\e[32m  OK  \e[0m] Hornet   | Hornet user and group Created'
 
HORNETURL=`wget -q -nv -O- https://api.github.com/repos/gohornet/hornet/releases/latest 2>/dev/null |  jq -r '.assets[] | select(.browser_download_url | contains("Linux_ARM.")) | .browser_download_url'`
echo -e '\e[90m[\e[0m INFO \e[90m]\e[0m Hornet   | Downloading Latest Version: '$HORNETURL
wget -Nqc --show-progress --progress=bar:force -O "/tmp/hornet-latest.tar.gz" $HORNETURL
tar -xzf "/tmp/hornet-latest.tar.gz" -C $HORNET_SRC --strip-components 1 && rm /tmp/hornet-latest.tar.gz && echo -e '[\e[32m  OK  \e[0m] Hornet   | Hornet Installed'

#Put latest version file
[[ $HORNETURL =~ .*(HORNET.+)\.tar\.gz  ]] && touch "$HORNET_SRC/latestversion-${BASH_REMATCH[1]}"

echo -e '\e[90m[\e[0m INFO \e[90m]\e[0m Hornet   | Getting latest snapshot file... \e[1m(this might take a bit)\e[0m'

wget -Nqc --show-progress --progress=bar:force -O "$HORNET_BIN/latest-export.gz.bin" https://dbfiles.iota.org/mainnet/hornet/latest-export.gz.bin

if [ ! -f  "$HORNET_BIN/latest-export.gz.bin" ]; then
	echo -e '[\e[31mFAILED\e[0m] Hornet   | '"Failed to downloading snapshot. ${aCOLOUR[3]} use hn-snapshot to download it after reboot.$COLOUR_RESET"
fi

#Linking binary file
ln -s $HORNET_SRC/hornet $HORNET_BIN/hornet

if [ -f /boot/config.json ]; then
	echo -e '[\e[32m  OK  \e[0m] Hornet   | Using user supplied config.json'
	cp -f /boot/config.json $HORNET_BIN/config.json
else
	echo -e '[\e[31mFAILED\e[0m] Hornet   | Could not find config.json using hornet default'
	cp $HORNET_SRC/config.json $HORNET_BIN/config.json
fi

#Change directories and files to hornet
chown -R $HORNETUSER:$HORNETUSER $HORNET_BIN $HORNET_SRC


echo "Setting up Service"
cat > $SERVICE_FILE <<EOF1
[Unit]
Description=HORNET Fullnode
After=network.target

[Service]
WorkingDirectory=$HORNET_BIN
SyslogIdentifier=hornet_service
TasksMax=infinity
KillSignal=SIGINT
ExecStart=$HORNET_BIN/hornet -c config
Restart=always
TimeoutStartSec=0
TimeoutStopSec=900
RestartSec=1200
User=$HORNETUSER
Group=$HORNETUSER

[Install]
WantedBy=multi-user.target
EOF1

systemctl daemon-reload && systemctl enable hornet.service && echo -e '[\e[32m  OK  \e[0m] Hornet   | Configured and Enabled Hornet Service' || echo -e '[\e[31mFAILED\e[0m] Hornet   | Problem Enabling Hornet Service'

#Get Hornet script files
mkdir /root/.hornet /home/dietpi/.hornet
curl -s "https://raw.githubusercontent.com/centercirclesolutions/dpi_hornet/$DPIH_BRANCH/.hornet/{.bash_aliases,.bash_hornet}" -o "/root/.hornet/#1" || echo -e '[\e[31mFAILED\e[0m] Hornet   | Failed to get Hornet admin scripts'
cp -r /root/.hornet/ /home/dietpi/
chown -R dietpi:dietpi /home/dietpi/.hornet

tee -a ~/.bashrc /home/dietpi/.bashrc > /dev/null <<EOF2
export HORNET_SRC="$HORNET_SRC"
export HORNET_BIN="$HORNET_BIN"

#Include alias file if it exists
if [ -f ~/.hornet/.bash_aliases ]; then
    . ~/.hornet/.bash_aliases
fi

#Include hornet file if it exists
if [ -f ~/.hornet/.bash_hornet ]; then
    . ~/.hornet/.bash_hornet
fi
EOF2


