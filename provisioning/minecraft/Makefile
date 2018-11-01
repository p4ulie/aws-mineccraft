java_package = java-1.8.0-openjdk-headless

minecraft_url = https://launcher.mojang.com/v1/objects/fe123682e9cb30031eae351764f653500b7396c9/server.jar

minecraft_dir_bin = /minecraft/bin
minecraft_dir_data = /minecraft/data
minecraft_dirs = /minecraft $(minecraft_dir_bin) $(minecraft_dir_data)

minecraft_user = minecraft
minecraft_group = $(minecraft_user)

#current_timestamp = $(shell date +%Y%m%d-%H%M%S)
#minecraft_filename = minecraft_server_$(current_timestamp).jar
minecraft_filename = minecraft_server.jar


.PHONY: minecraft
minecraft: java minecraft_download install service_install


.PHONY: java
java:
	@echo "Installing java $(java_package)..."
	@yum install -y $(java_package)


.PHONY: adduser
adduser:
	@echo "Adding user $(minecraft_user)..."
	@id -u $(minecraft_user) &>/dev/null || useradd --system $(minecraft_user)


.PHONY: dirs
dirs: adduser
	@echo "Creating $(minecraft_dirs)..."
	@mkdir -p $(minecraft_dirs)
	@chown -R $(minecraft_user):$(minecraft_group) $(minecraft_dirs)


.PHONY: minecraft_download
minecraft_download:
	@echo "Downloading minecraft server binary..."
	@curl --remote-time --progress-bar --location \
        --time-cond "$(minecraft_filename)" -o "$(minecraft_filename)" "$(minecraft_url)"


.PHONY: install
install: dirs adduser
	@echo "Installing minecraft server $(minecraft_filename) to $(minecraft_dir_bin)"
	@cp -f $(minecraft_filename) "$(minecraft_dir_bin)"
	@chown $(minecraft_user):$(minecraft_group) "$(minecraft_dir_bin)/$(minecraft_filename)"


.PHONY: service_install
service_install:
	@echo "Installing minecraft service..."
	@cp -f resources/minecraft.service /etc/systemd/system/minecraft.service
	@systemctl daemon-reload
	@systemctl enable minecraft


.PHONY: service_uninstall
service_uninstall:
	@echo "Removing minecraft service..."
	@systemctl | grep minecraft.service &>/dev/null && systemctl stop minecraft || echo -n ""
	@rm -rf /etc/systemd/system/minecraft.service
	@systemctl daemon-reload


.PHONY: clean
clean:
	@echo "Deleting downloaded jar files..."
	@rm -rf "*.jar"


.PHONY: distclean
distclean: clean service_uninstall
	@echo "Deleting $(minecraft_dirs)..."
	@rm -rf $(minecraft_dirs)
	@echo "Deleting user $(minecraft_user)..."
	@id -u $(minecraft_user) &>/dev/null || useradd --system $(minecraft_user)
