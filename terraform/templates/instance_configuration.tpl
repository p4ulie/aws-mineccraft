#!/usr/bin/env bash
#
# Provision packages and set-up instance during first launch
# Ment to run as user data of EC2 instance (which runs as root)
#

aws s3 cp s3://${MINECRAFT_S3_BUCKET_NAME} /tmp --recursive --exclude "*" --include "minecraft_server_*.zip" 

mkdir -p "${MINECRAFT_DIRECTORY}/data"

rm -f "${MINECRAFT_DIRECTORY}/data/logs/*"                                                                                                                                   
rm -f "${MINECRAFT_DIRECTORY}/data/world/*"                                                                                                                                  
rm -f "${MINECRAFT_DIRECTORY}/data/*"                                                                                                                                        
                   
unzip -o -d "${MINECRAFT_DIRECTORY}/data/logs" /tmp/minecraft_server_logs.zip 
unzip -o -d "${MINECRAFT_DIRECTORY}/data/world" /tmp/minecraft_server_world.zip 
unzip -o -d "${MINECRAFT_DIRECTORY}/data" /tmp/minecraft_server_settings.zip 

chown -R ${MINECRAFT_USER}:${MINECRAFT_GROUP} "${MINECRAFT_DIRECTORY}"

rm -f /tmp/minecraft_server_*.zip

systemctl enable minecraft.service
systemctl start minecraft.service

exit 0