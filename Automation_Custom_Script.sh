#!/bin/bash
# This script will install Hornet
#The user can put config.json file in the /boot directory which will be copied into the hornet directory
#This file should be installed at: /boot/Automation_Custom_Script.sh
if [[ $1 ]]; then
	BRANCH="$1"
else
	BRANCH="master"
fi

BRANCH=
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

echo "Installing Tools"
apt-get install -qq -y jq

#Install Error handeling
if ! [ -x "$(command -v jq)" ]; then
  echo 'Problem installing... trying one more time' >&2

  apt-get install -qq -y jq

  if ! [ -x "$(command -v jq)" ]; then
    echo 'Error: softare did not install' >&2
    exit 1
  fi
fi

#GLOBAL###############################################
HORNET_SRC="/opt/hornet_src"
HORNET_BIN="/opt/hornet"
SERVICE_FILE="/etc/systemd/system/hornet.service"
HORNETUSER=hornet
######################################################

echo "Add 'hornet' system user/group and create directories"
adduser --system --group --no-create-home $HORNETUSER
mkdir $HORNET_SRC
mkdir $HORNET_BIN
mkdir $HORNET_BIN/config_history

chown -R $HORNETUSER:$HORNETUSER $HORNET_BIN $HORNET_SRC
 
echo "Getting the latest version of Hornet..."
HORNETURL=`wget -q -nv -O- https://api.github.com/repos/gohornet/hornet/releases/latest 2>/dev/null |  jq -r '.assets[] | select(.browser_download_url | contains("Linux_ARM.")) | .browser_download_url'`
echo "Downloading: $HORNETURL"
wget -Nqc --show-progress --progress=bar:force -O "/tmp/hornet-latest.tar.gz" $HORNETURL
echo "Unpacking..."
tar -xzf "/tmp/hornet-latest.tar.gz" -C $HORNET_SRC --strip-components 1
rm /tmp/hornet-latest.tar.gz

#Put latest version file
[[ \$HORNETURL =~ .*(HORNET.+)\.tar\.gz  ]] && touch "\$HORNET_SRC/latestversion-\${BASH_REMATCH[1]}"

echo -e "Downloading the latest snapshot file... ${aCOLOUR[0]}(this might take a bit)$COLOUR_RESET"
wget -Nqc --show-progress --progress=bar:force -O "$HORNET_BIN/latest-export.gz.bin" https://dbfiles.iota.org/mainnet/hornet/latest-export.gz.bin

if [ ! -f  "$HORNET_BIN/latest-export.gz.bin" ]; then
	echo -e "There was a problem downloading the snapshot. ${aCOLOUR[3]}You will need to download the snapshot file after the restart$COLOUR_RESET"
fi

#Linking binary file
ln -s $HORNET_SRC/hornet $HORNET_BIN/hornet

if [ -f /boot/config.json ]; then
	echo -e "Found the user supplied config.json file in /boot directory"
	cp -f /boot/config.json $HORNET_BIN/config.json
else
	echo -e "Using the config.json file from github... ${aCOLOUR[3]}please edit after restart$COLOUR_RESET"
	cp $HORNET_SRC/config.json $HORNET_BIN/config.json
fi

#Change directories and files to hornet
chown -R $HORNETUSER:$HORNETUSER $HORNET_BIN $HORNET_SRC

#Setup SHR remount on startup
#sed -i '/^tmpfs \/tmp tmpfs/s/^/#/' /etc/fstab
 
#	sed -i -- '/tmpfs \/DietPi/itmpfs /dev/shm tmpfs defaults,size=100M 0 0' /etc/fstab

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

echo "Enabling Services... Hornet Service will start on reboot"
systemctl daemon-reload 
systemctl enable hornet.service

git clone 
 

tee -a ~/.bashrc /home/dietpi/.bashrc > /dev/null <<EOF2
export HORNET_SRC="$HORNET_SRC"
export HORNET_BIN="$HORNET_BIN"

#Include alias file if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#Include hornet file if it exists
if [ -f ~/.bash_hornet ]; then
    . ~/.bash_hornet
fi
EOF2


