#!/usr/bin/env bash
#
# Provision packages and set-up instance during first launch
# Ment to run as user data of EC2 instance (which runs as root)
#

# =============================================================================
#                             Basic provisioning
# =============================================================================

# Install AWS Systems Manager client
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Install basic tools and utilities
yum install -y screen tmux unzip

# Create Minecraft group and user
groupadd "${MINECRAFT_GROUP}"
useradd --create-home --gid "${MINECRAFT_GROUP}" "${MINECRAFT_USER}"

# Create installation and data directories
mkdir -p "${MINECRAFT_DIRECTORY}"
mkdir -p "${MINECRAFT_DIRECTORY}/data"
mkdir -p "${MINECRAFT_DIRECTORY}/bin"

# download the Minecraft server file and set owner of file
curl --remote-time --progress-bar --location \
	--time-cond "${MINECRAFT_DIRECTORY}/bin/${MINECRAFT_SERVER_FILENAME}" \
	-o "${MINECRAFT_DIRECTORY}/bin/${MINECRAFT_SERVER_FILENAME}" \
	"${MINECRAFT_DIRECTORY}"

chown ${MINECRAFT_USER}${MINECRAFT_GROUP} "${MINECRAFT_DIRECTORY}/bin/${MINECRAFT_SERVER_FILENAME}"

# create a file accepting EULA
echo "eula=true" > "${MINECRAFT_DIRECTORY}/data/eula.txt"
chown ${MINECRAFT_USER}${MINECRAFT_GROUP} "${MINECRAFT_DIRECTORY}/data/eula.txt"

exit 0