# Hornet Auto-installation for DietPi
This is an attempt at automating the installation of Hornet for the Raspberry Pi (3 and 4) using DietPi. It is not using Docker or the Nuriel's awesome hornet-playbook as it focuses on providing a minimal install and memory footprint to run Hornet while still providing some tools to manage the Hornet Node. 

Below are the instructions to install the software. During installation DietPi will load the latest (Automation_Custom_Script.sh) from this repository and run it only during the initial installation.

All scripts and config files used (`Automation_Custom_Script.sh` and `dietpi.txt`) are in this repo and available for you to review. If you find any issues please add an issue (or feature). You may PM me  Dave [EF]  on Discord but since I am timzone challanged I may take several hours to get back on issues. Feel free to provide Updates and Pull requests as well.

## Instructions

### 1. Download DietPi for Raspberry Pi.
[DietPi_RPi-ARMv6-Buster.7z](https://dietpi.com/downloads/images/DietPi_RPi-ARMv6-Buster.7z) (This image will work for both Pi 3 & 4).

### 2. Flash to SD card.
**Extract** the `DietPi_RPi-ARMv6-Buster.img file` and use your favorite imaging tool to flash the image to your SD card.
#### My Favorite ([Rufus](https://rufus.ie/)).

### 3. Download and customize dietpi.txt.
Download the dietpi.txt file from this repository and prepare / customize it for your Raspberry Pi.<br>
For more info see: [Preparing the dietpi.txt File](CustomizeDietPiFile.md).

### 4. Copy dietpi.txt to the SD card
Copy the customized dietpi.txt file to the base directory of the SD card (Named boot) you will be asked if you want to replace the existing file and you should.

### 5. Prepare Hornet config.json file.
For more info see: [Preparing Hornet config.json file](CustomizeConfigJSON.md).

### 6. Copy config.json to SD card 
Copy the config.json file that contains your hronet neighbors and other configurations to the base directory of the SD Card (Named boot).

If you forget to copy the config.json file to the SD card the installation will use the config.json from the Hornet repository. It will be necessary to modify this after the installation finishes and DietPi Reboots. You will see a red message during the hornet install if this is the case.

### 7. Insert SD Card into Raspberry Pi and turn it on.
The DietPi installation should take about 10 to 20 minutes depending on your network speed and version of Pi. You will see a banner for Hornet the Hornet installation at the end.

### 8. Done!
Your Pi will reboot and you can log in with User: root or dietpi and the Password in the dietpi.txt file. 

You can see the status of the node with either hn-st or via the API hn-inf
![](/img/hornet-status.png)
![](/img/hornet-info.png)

Remember to change the password for both root and dietpi users. Hornet will start on boot and you can check the status and other operations with the following commands:

| Command      | Description                                                                         |
| ------------ |-------------------------------------------------------------------------------------|
| hn-          | List all Hornet Node commands   |
| hn-v         | Hornet Version |
| hn-st        | Hornet Node Status                                                                  |
| hn-lg        | Hornet Node Log                                                                     |
| hn-lgf       | Hornet Node Log Follow - shows the log continously (^c to exit)                     |
| hn-rs        | Hornet Node Restart                                                                 |
| hn-up        | Hornet Node Up (Start)                                                              |
| hn-dn        | Hornet Node Down (Stop)                                                             |
| hn-snap      | Hornet Node Download new Snapshot file (No D/L if not new)                          |
| hn-rmdb      | Hornet Node Remove Database (use when corrupted)                                    |
| hn-repair    | Hornet Node Repair - Remove corrupt DB (Stop / remove DB / D/L Snapshot / Restart)  |
| hn-inf       | Hornet Node Information (API)                                                       |
| hn-infn      | Hornet Node Neighbor Information                                                    | 
| hn-addnb     | Hornet Node Add Neighbor (API)                                                      |
| hn-remnb     | Hornet Node Remove Neighbor (API)                                                   | 
| hn-update    | Update Hornet: `hn-update [-fr]` <br> -f Update even if same version<br> -r Restart Hornet after update|
| hn-profile   | Update Hornet profile: `hn-profile 2gb` ( you will need to restart the server for this to take effect|

### 9. Run DietPi from external SSD
Since the hornet node reads and writes from disk frequently and has extensive logging it will be almost necessary to run the hornet node from an external SDD. Luckily DietPi has a configuration tool to automoate this. 

**Provide Examples TBD**
`dietpi-drive_manager`
