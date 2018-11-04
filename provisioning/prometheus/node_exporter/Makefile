application = node_exporter
application_version = 0.16.0

application_service = $(application)

download_url = https://github.com/prometheus/$(application)/releases/download/v$(application_version)/$(application)-$(application_version).linux-amd64.tar.gz

application_dir = /opt/$(application)

application_user = $(application)
application_group = $(application_user)

package_filename = $(notdir $(download_url))
application_dirname = $(basename $(basename $(package_filename)))


.PHONY: $(application)
$(application):  download install service_install


.PHONY: adduser
adduser:
	@echo "Adding user $(application_user)..."
	@id -u $(application_user) &>/dev/null || useradd --system $(application_user)


.PHONY: download
download:
	@echo "Downloading $(application) binary..."
	@curl --remote-time --progress-bar --location \
        --time-cond "$(package_filename)" -o "$(package_filename)" "$(download_url)"


.PHONY: install
install: adduser download
	@echo "Installing $(application) binary..."
	@tar --directory=/opt -zxvf "$(package_filename)"

	@chown -R $(application_user):$(application_group) $(application_dir)*

	@rm -f "$(application_dir)"
	@ln -s "/opt/$(application_dirname)" "$(application_dir)"


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
	@echo "Deleting downloaded tar.gz files..."
	@rm -rf *.tar.gz


.PHONY: distclean
distclean: clean service_uninstall
	@echo "Deleting  $(application) config files and directories ..."
	@rm -rf $(application_dir)*

	# @echo "Deleting user $(application_user)..."
	# @id -u $(application_user) &>/dev/null && userdel $(application_user) || echo -n ""