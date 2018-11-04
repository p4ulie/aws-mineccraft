application = minecraft
application_service = $(application)

java_package = java-1.8.0-openjdk-headless

download_url = https://launcher.mojang.com/v1/objects/fe123682e9cb30031eae351764f653500b7396c9/server.jar

base_dir = /opt

application_basedir = $(base_dir)/$(application)
application_dir_bin = $(application_basedir)/bin
application_dir_data = $(application_basedir)/data
application_dirs = $(application_basedir) $(application_dir_bin) $(application_dir_data)

application_user = $(application)
application_group = $(application_user)

#current_timestamp = $(shell date +%Y%m%d-%H%M%S)
#package_filename = minecraft_server_$(current_timestamp).jar
package_filename = minecraft_server.jar


.PHONY: $(application)
$(application): java download install service_install


.PHONY: java
java:
	@echo "Installing java $(java_package)..."
	@yum install -y $(java_package)


.PHONY: adduser
adduser:
	@echo "Adding user $(application_user)..."
	@id -u $(application_user) &>/dev/null || useradd --system $(application_user)


.PHONY: dirs
dirs: adduser
	@echo "Creating $(application_dirs)..."
	@mkdir -p $(application_dirs)
	@chown -R $(application_user):$(application_group) $(application_dirs)


.PHONY: download
download:
	@echo "Downloading $(application) server binary..."
	@curl --remote-time --progress-bar --location \
        --time-cond "$(package_filename)" -o "$(package_filename)" "$(download_url)"


.PHONY: install
install: dirs adduser download
	@echo "Installing $(application) server $(package_filename) to $(application_dir_bin)"
	@cp -f $(package_filename) "$(application_dir_bin)"
	@chown $(application_user):$(application_group) "$(application_dir_bin)/$(package_filename)"

	@echo "eula=true" > "$(application_dir_data)/eula.txt"
	@chown $(application_user):$(application_group) "$(application_dir_data)/eula.txt"


.PHONY: service_install
service_install:
	@echo "Installing $(application) service..."
	@cp -f resources/$(application_service).service /etc/systemd/system/$(application_service).service
	@systemctl daemon-reload
	@systemctl enable $(application_service)


.PHONY: service_uninstall
service_uninstall:
	@echo "Removing $(application) service..."
	@systemctl | grep $(application_service).service &>/dev/null && systemctl stop $(application_service) || echo -n ""
	@rm -rf /etc/systemd/system/$(application_service).service
	@systemctl daemon-reload


.PHONY: start
start:
	@systemctl start $(application_service)


.PHONY: stop
stop:
	@systemctl stop $(application_service)


.PHONY: clean
clean:
	@echo "Deleting downloaded jar files..."
	@rm -rf *.jar


.PHONY: distclean
distclean: clean service_uninstall
	@echo "Deleting $(application_dirs)..."
	@rm -rf $(application_dirs)
	@echo "Deleting user $(application_user)..."
	@id -u $(application_user) &>/dev/null && userdel $(application_user) || echo -n ""