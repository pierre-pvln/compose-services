#!/bin/bash
# copy archive files to site folder

echo copy archive files from docker container to rpi3

scp -r /var/www/voluntas/administrator/components/com_akeeba/backup/*.jpa pi@192.168.2.11:/tmp/archive/
