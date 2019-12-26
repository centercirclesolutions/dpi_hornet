# Hornet Autoinstallation for DietPi

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
For more info see: [Preparing Hornet config.json file](CustomizeDietPiFile.md).

### 6. Copy config.json to SD card 
Copy the config.json file that contains your hronet neighbors and other configurations to the base directory of the SD Card (Named boot).

### 7. Insert SD Card into Raspberry Pi and turn it on.
The DietPi installation should take about 10 to 20 minutes depending on your network speed and version of Pi. You will see a banner for Hornet the Hornet installation at the end.

### 8. Done!
Your Pi will reboot and you can log in with User: root or dietpi and the Password in the dietpi.txt file. Remember to hange the password for both root and dietpi users. Hornet will start on boot and you can check the status and other operations with the following commands:

| Command    | Description                                                                         |
| ---------- |-------------------------------------------------------------------------------------|
| hns        | Hornet Node Status                                                                  |
| hnl        | Hornet Node Log                                                                     |
| hnlf       | Hornet Node Log Follow - shows the log continously (^c to exit)                     |
| hnr        | Hornet Node Restart                                                                 |
| hnu        | Hornet Node Up (Start)                                                              |
| hnd        | Hornet Node Down (Stop)                                                             |
| hnsnap     | Hornet Node Download new Snapshot file (No D/L if not new)                          |
| hnrepair   | Hornet Node Repair - Remove corrupt DB (Stop / remove DB / D/L Snapshot / Restart)  |

### 9. Run DietPi from external SSD
Since the hornet node reads and writes from disk frequently and has extensive logging it will be almost necessary to run the hornet node from an external SDD. Luckily DietPi has a configuration tool to automoate this. 

**Provide Examples TBD**
`dietpi-drive_manager`
