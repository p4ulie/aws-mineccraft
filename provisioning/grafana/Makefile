application = grafana
application_service = $(application)-server

download_url = https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.1.4-1.x86_64.rpm

package_filename = $(notdir $(download_url))
package_name = $(basename package_filename)


.PHONY: $(application)
$(application):  download install


.PHONY: download
download:
	@echo "Downloading $(application) package..."
	@curl --remote-time --progress-bar --location \
        --time-cond "$(package_filename)" -o "$(package_filename)" "$(download_url)"


.PHONY: install
install: download
	@echo "Installing $(application) package..."
	@yum localinstall -y $(package_filename)
	@systemctl enable $(application_service)


.PHONY: uninstall
uninstall:
	@echo "Uninstalling $(application) package..."
	# @systemctl | grep $(application_service).service &>/dev/null && systemctl stop $(application_service) || echo -n ""
	# @systemctl disable $(application_service)
	@yum remove -y $(application)


.PHONY: start
start:
	@systemctl start $(application_service)


.PHONY: stop
stop:
	@systemctl stop $(application_service)


.PHONY: clean
clean:
	@echo "Deleting downloaded *.rpm files..."
	@rm -rf *.rpm


.PHONY: distclean
distclean: clean uninstall
