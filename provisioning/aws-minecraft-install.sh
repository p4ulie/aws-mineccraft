#!/usr/bin/env bash

yum install java-1.8.0-openjdk-headless

useradd minecraft

mkdir /minecraft

mkdir /minecraft/bin /minecraft/data

cd /minecraft/bin
wget https://launcher.mojang.com/v1/objects/fe123682e9cb30031eae351764f653500b7396c9/server.jar
cd -

chown -R minecraft:minecraft /minecraft

exit 0
