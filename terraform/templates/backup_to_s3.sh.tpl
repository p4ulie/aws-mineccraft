#!/bin/env bash

pushd ${MINECRAFT_DIRECTORY}/data/world
zip -r /tmp/minecraft_server_world.zip *
popd

pushd ${MINECRAFT_DIRECTORY}/data/logs
zip -r /tmp/minecraft_server_logs.zip *
popd

pushd ${MINECRAFT_DIRECTORY}/data
zip -j /tmp/minecraft_server_settings.zip * -x world -x logs
popd

aws s3 mv /tmp/ s3://${MINECRAFT_S3_BUCKET_NAME} --recursive --exclude "*" --include "minecraft_server_*.zip"

exit 0
