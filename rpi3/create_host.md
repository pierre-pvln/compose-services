Installing the image
- Download image raspberry pi 3 debian image
- Put it on SD card using Ether (from etcher.io)
- Make shore that terminal, keyboard en netwerkcable is connected
- Insert SD card in raspberry pi3 and power up.

Raspberry will boot to graphical user interface.
- in menu -> Preferences -> Mouse and Keyboard settings
  - change/check keyboard settings shift-3 to get #

- in menu -> Preferences -> Raspberry Pi Configuration -> System
  - change hostname to : raspberrypi3
  - change password to : <_a_new_password_>
- in menu -> Preferences -> Raspberry Pi Configuration -> Interfaces
  - change SSH to yes
- in menu -> Preferences -> Raspberry Pi Configuration -> Localisation
  - change Timezone to Europe -> Amsterdam
  - change WiFi Country to NL  

Now reboot the raspberry pi 3

Get the latest versions:
- Open terminal and:
```script
sudo apt-get update
sudo apt-get -y upgrade
```
Then reboot the raspberry pi 3
```script
sudo reboot now
```

In a terminal
```script
cd ~
curl -O -L https://raw.githubusercontent.com/pierre-pvln/compose-on_host/master/prepare_docker_host.sh
chmod +x *.sh
./prepare_docker_host.sh
```

Now you should have the required structure and files

