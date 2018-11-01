prometheus_url = https://github.com/prometheus/prometheus/releases/download/v2.4.3/prometheus-2.4.3.linux-amd64.tar.gz

prometheus_dir = /opt/prometheus

prometheus_user = prometheus
prometheus_group = $(prometheus_user)

prometheus_filename = $(notdir $(prometheus_url))
prometheus_dirname = $(basename $(basename $(prometheus_filename)))


.PHONY: prometheus
prometheus:  download install service_install


.PHONY: adduser
adduser:
	@echo "Adding user $(prometheus_user)..."
	@id -u $(prometheus_user) &>/dev/null || useradd --system $(prometheus_user)


.PHONY: download
download:
	@echo "Downloading prometheus binary..."
	@curl --remote-time --progress-bar --location \
        --time-cond "$(prometheus_filename)" -o "$(prometheus_filename)" "$(prometheus_url)"


.PHONY: install
install: adduser download
	@echo "Installing prometheus binary..."
	tar --directory=/opt -zxvf "$(prometheus_filename)"

	chown -R $(prometheus_user):$(prometheus_group) $(prometheus_dir)*

	rm -f /opt/prometheus
	ln -s "/opt/$(prometheus_dirname)" "$(prometheus_dir)"

	rm -f /etc/prometheus.yml
	ln -s "$(prometheus_dir)/prometheus.yml" /etc


.PHONY: service_install
service_install:
	@echo "Installing prometheus service..."
	@cp -f resources/prometheus.service /etc/systemd/system/prometheus.service
	@systemctl daemon-reload
	@systemctl enable prometheus


.PHONY: service_uninstall
service_uninstall:
	@echo "Removing prometheus service..."
	@systemctl | grep prometheus.service &>/dev/null && systemctl stop prometheus || echo -n ""
	@rm -rf /etc/systemd/system/prometheus.service
	@systemctl daemon-reload


.PHONY: clean
clean:
	@echo "Deleting downloaded tar.gz files..."
	@rm -rf *.tar.gz


.PHONY: distclean
distclean: clean service_uninstall
	@echo "Deleting prometheus config files and directories ..."
	@rm -rf $(prometheus_dir)*
	@rm -f /etc/prometheus.yml

	@echo "Deleting user $(prometheus_user)..."
	@id -u $(prometheus_user) &>/dev/null && userdel $(prometheus_user) || echo -n ""