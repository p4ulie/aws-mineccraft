#!/bin/env bash

pushd /opt/minecraft/data/world
zip -r /tmp/minecraft_server_world.zip *
popd

pushd /opt/minecraft/data/logs
zip -r /tmp/minecraft_server_logs.zip *
popd

pushd /opt/minecraft/data
zip -j /tmp/minecraft_server_settings.zip * -x world -x logs
popd#aws s3 mv /tmp/ s3://s3-minecraft-p4ulie-net-world-backup --recursive --exclude "*" --include "minecraft_server_*.zip"

exit 0
