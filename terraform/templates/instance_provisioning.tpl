#!/usr/bin/env bash
#
# Provision packages and set-up instance during first launch
# Ment to run as user data of EC2 instance (which runs as root)
#

# =============================================================================
#                             Basic provisioning
# =============================================================================

# Install basic tools and utilities
yum install -y screen

# Create Minecraft group and user
groupadd "${MINECRAFT_GROUP}"
useradd --create-home --gid "${MINECRAFT_GROUP}" "${MINECRAFT_USER}"

# Create installation and data directories
mkdir -p "${MINECRAFT_DIRECTORY}"
mkdir -p "${MINECRAFT_DIRECTORY}/data"
mkdir -p "${MINECRAFT_DIRECTORY}/bin"

chown -R ${MINECRAFT_USER}:${MINECRAFT_GROUP} "${MINECRAFT_DIRECTORY}"

# download the Minecraft server file and set owner of file
curl --remote-time --progress-bar --location \
	--time-cond "${MINECRAFT_DIRECTORY}/bin/${MINECRAFT_SERVER_FILENAME}" \
	--output "${MINECRAFT_DIRECTORY}/bin/${MINECRAFT_SERVER_FILENAME}" \
	"${MINECRAFT_DOWNLOAD_URL}"

chown ${MINECRAFT_USER}:${MINECRAFT_GROUP} "${MINECRAFT_DIRECTORY}/bin/${MINECRAFT_SERVER_FILENAME}"

# create a file accepting EULA
echo "eula=true" > "${MINECRAFT_DIRECTORY}/data/eula.txt"
chown ${MINECRAFT_USER}:${MINECRAFT_GROUP} "${MINECRAFT_DIRECTORY}/data/eula.txt"

exit 0