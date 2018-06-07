#!/bin/bash
# copy archive files to site folder

echo copy from rpi3 to docker container

scp -r pi@192.168.2.11:/tmp/archive/*.* /var/www/voluntas
