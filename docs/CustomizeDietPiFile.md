# Customize DietPi.txt
DietPi uses a configuration file named dietpi.txt. This file contains all the initial configuration options that DietPi will use when setting up the Operating System. I have provided a template dietpi.txt file that will support hornet installation but there are other configurations that differ by country and region or network situation. Please review the blow options for more information on what my be necessary to change. 

##### Line 13 - Set Locale
```bash
11 ##### Language/Regional Options #####
12 # Locale: eg: "en_GB.UTF-8" / "de_DE.UTF-8" | One entry and UTF-8 ONLY!
13 AUTO_SETUP_LOCALE=en_US.UTF-8
```
##### Line 16 - Set Keyboard Layout
```bash
15 # Keyboard Layout eg: "gb" / "us" / "de" / "fr"
16 AUTO_SETUP_KEYBOARD_LAYOUT=us
```
##### Line 19 - Set Timezone
```bash
18 # Timezone eg: "Europe/London" / "America/New_York" | Full list (TZ*): https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
19 AUTO_SETUP_TIMEZONE=America/New_York
```
##### Line 25 & 26 - Enable Network Options
Dietpi will have a default networking option active at startup. Enable either Ethernet or Wifi.If you choose Wifi then there is an additional file to edit to add the SSID and key for your Wifi network
```bash
25 AUTO_SETUP_NET_ETHERNET_ENABLED=1
26 AUTO_SETUP_NET_WIFI_ENABLED=0
```
###### OR
```bash
25 AUTO_SETUP_NET_ETHERNET_ENABLED=0
26 AUTO_SETUP_NET_WIFI_ENABLED=1
```
##### Add Wifi credentials if Wifi is enabled
Edit the dietpi-wifi.txt file in the same root directory and add your SSID name and password
```bash
1 #---------------------------------------------------------------
2 # - Entry 0
3 #       WiFi SSID (Case Sensitive)
4 aWIFI_SSID[0]='myrouter'
5 #       Key options: If no key (open), leave this blank
6 aWIFI_KEY[0]='secretpassword'
```
##### Line 101 - Set initial installed Password (Best to leave this and change after install)
```bash
# Global Password to be applied for the system
# - Affects user "root" and "dietpi" login passwords, and, all software installed by dietpi-software, that requires a login password
# - WARN: Passwords with any of the following characters are not supported: \"$
AUTO_SETUP_GLOBAL_PASSWORD=hornet
```
