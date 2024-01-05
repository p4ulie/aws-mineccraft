[Unit]
Description=Minecraft Server
After=network.target

[Service]
WorkingDirectory=${MINECRAFT_DIRECTORY}/data

User=${MINECRAFT_USER}
Group=${MINECRAFT_GROUP}

Restart=always

ExecStart=/usr/bin/java ${MINECRAFT_JOPTS} -jar "${MINECRAFT_DIRECTORY}/bin/minecraft_server.jar" nogui
ExecStopPost=/opt/minecraft/bin/backup_to_s3.sh
#ExecStart=/usr/bin/java -Xms1024M -Xmx1024M -javaagent:/opt/jmx_exporter/jmx_exporter.jar=9200:/opt/jmx_exporter/config.yaml -jar "${MINECRAFT_DIRECTORY}/bin/minecraft_server.jar" nogui

[Install]
WantedBy=multi-user.target
