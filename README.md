# Hornet Autoinstallation for DietPi

## Instructions

### 1. Download DietPi for Raspberry Pi.
[DietPi_RPi-ARMv6-Buster.7z](https://dietpi.com/downloads/images/DietPi_RPi-ARMv6-Buster.7z) (This image will work for both Pi 3 & 4)

### 2. Flash to SD card.
**Extract** the `DietPi_RPi-ARMv6-Buster.img file` and use your favorite imaging tool to flash the image to your SD card
#### My Favorite ([Rufus](https://rufus.ie/))

### 3. Download and customize dietpi.txt.
Download the dietpi.txt file from this repository and prepare / customize it for your Raspberry Pi.<br>
For more info see: [Preparing the dietpi.txt File](CustomizeDietPiFile.md)

### 4. Replace dietpi.txt on the SD card with your customized DietPi.txt file.

### 5. Prepare Hornet config.json file.
For more info see: [Preparing Hornet config.json file](CustomizeDietPiFile.md)

### 6. Copy config.json to SD card (Base Directory)

### 7. Insert SD Card into Raspberry Pi and turn it on.

### Done!
Your Pi will reboot and you can log in with User: root and the Password in the dietpi.txt file. Remember to hange the password for both root and dietpi users. Hornet will start on boot and you can check the status and other operations with the following commands:

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
