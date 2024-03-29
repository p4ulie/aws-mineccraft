#!/usr/bin/env bash
#
# Provision packages and set-up instance during first launch
# Ment to run as user data of EC2 instance (which runs as root)
#

# =============================================================================
#                             Basic provisioning
# =============================================================================

# Install basic tools and utilities
yum install -y screen tmux

# Install Java - Amazon Coretto
yum install -y java-17-amazon-corretto-devel

# Create Minecraft group and user
groupadd "${MINECRAFT_GROUP}"
useradd --create-home --gid "${MINECRAFT_GROUP}" "${MINECRAFT_USER}"

# Create installation and data directories
mkdir -p "${MINECRAFT_DIRECTORY}"
mkdir -p "${MINECRAFT_DIRECTORY}/data"
mkdir -p "${MINECRAFT_DIRECTORY}/bin"

chown -R ${MINECRAFT_USER}:${MINECRAFT_GROUP} "${MINECRAFT_DIRECTORY}"

# create a file accepting EULA
echo "eula=true" > "${MINECRAFT_DIRECTORY}/data/eula.txt"
chown ${MINECRAFT_USER}:${MINECRAFT_GROUP} "${MINECRAFT_DIRECTORY}/data/eula.txt"

# prepare backup script
mv /home/ec2-user/backup_to_s3.sh "${MINECRAFT_DIRECTORY}/bin/backup_to_s3.sh"
chown "${MINECRAFT_USER}:${MINECRAFT_GROUP}" "${MINECRAFT_DIRECTORY}/bin/backup_to_s3.sh"

# prepare restore script
mv /home/ec2-user/restore_from_s3.sh "${MINECRAFT_DIRECTORY}/bin/restore_from_s3.sh"
chown "${MINECRAFT_USER}:${MINECRAFT_GROUP}" "${MINECRAFT_DIRECTORY}/bin/restore_from_s3.sh"

# prepare service script
mv /home/ec2-user/minecraft.service /etc/systemd/system/minecraft.service
chown root:root /etc/systemd/system/minecraft.service

# download the Minecraft server file and set owner of file
curl --remote-time --progress-bar --location \
	--time-cond "${MINECRAFT_DIRECTORY}/bin/${MINECRAFT_SERVER_FILENAME}" \
	--output "${MINECRAFT_DIRECTORY}/bin/${MINECRAFT_SERVER_FILENAME}" \
	"${MINECRAFT_DOWNLOAD_URL}"

chown ${MINECRAFT_USER}:${MINECRAFT_GROUP} "${MINECRAFT_DIRECTORY}/bin/${MINECRAFT_SERVER_FILENAME}"

# prepare service definition file
systemctl daemon-reload

exit 0
