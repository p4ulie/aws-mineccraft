#!/bin/env bash

zip -j /tmp/minecraft_server_world.zip ${MINECRAFT_DIRECTORY}/data/world/*
zip -j /tmp/minecraft_server_logs.zip ${MINECRAFT_DIRECTORY}/data/logs/*
zip -j /tmp/minecraft_server_settings.zip ${MINECRAFT_DIRECTORY}/data/* -x world -x logs
aws s3 mv /tmp/ s3://${MINECRAFT_S3_BUCKET_NAME} --recursive --exclude "*" --include "minecraft_server_*.zip"

exit 0
