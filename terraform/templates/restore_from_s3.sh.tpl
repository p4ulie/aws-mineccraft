#!/bin/env bash

aws s3 mv s3://${MINECRAFT_S3_BUCKET_NAME} /tmp --recursive --exclude "*" --include "minecraft_server_*.zip"

unzip -d "${MINECRAFT_DIRECTORY}/data/logs" /tmp/minecraft_server_logs.zip
unzip -d "${MINECRAFT_DIRECTORY}/data/world" /tmp/minecraft_server_world.zip
unzip -d "${MINECRAFT_DIRECTORY}/data" /tmp/minecraft_server_settings.zip

exit 0
