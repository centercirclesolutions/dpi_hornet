# Customize Hornet config.json file
The Hornet node uses the config.json file to configure the node's settings on startup. This guide will not cover all the settings but just those that I've found important to making Hornet run more stable on DietPi.

##### runProfile
```bash
"useProfile": "auto",
```
For Raspberry Pi 4's with 4 GB of memory it's best to leave this set at auto where hornet will choose the best profile. If you get Out of Memory errors on the inital syncing up I've found that setting this to 2gb, running the initial sync, then setting back to auto will get past that problem. There might be some other connfiguration changes that will manage the memory better but DietPi caches many things in memory to speed them up and that sometimes clashes with other processes like hornet. On a 4GB Pi4 DietPi allocates 2GB of memory for this but it is not all initially used. When logging becomes heavy and the hornet process uses up memory then the OOM condition occurs.

##### Dashboard host
````bash
"dashboard": {
    "host": "127.0.0.1",
````
The dashboard host is initially set to the IP for the localhost. This means you can only see the dashboard from the DietPi. I reccoment changing this to `0.0.0.0` so that you can see the dashboard from other machines on your LAN (or externally if you open the dashboard port)

##### maxneighbors, neighbors and port
```bash
    "maxneighbors": 5,
    "neighbors": [
      {
        "identity": "example1.neighbor.com:15600",
        "preferIPv6": false
      },
      {
        "identity": "example2.neighbor.com:15600",
        "preferIPv6": false
      },
      {
        "identity": "example3.neighbor.com:15600",
        "preferIPv6": false
      }
    ],
    "port": 15600,
```
You will need to change and add neighbors here in the config file. You do not need to use the `TCP://` that th IRI nodes use. The port can be left alone initially but if you run multiple nodes you may need to change these to be unique (based on your gateway and port mapping requirements)

##### Plugins
```bash
  "node": {
    "disableplugins": [],
    "enableplugins": ["Spammer", "ZeroMQ"],
```
Currently there are several Plugins you can enable 
* "Monitor" - Tangle Monitor Front end running on Hornet Server (Port 4434) May require additional setup
* "Spammer" - Spammer running on the node (Currently not interactive)
* "ZeroMQ" - ZMQ interface for server stats and such
