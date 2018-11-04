application = jmx_exporter
application_version = 0.3.1

#application_service = $(application)

download_url = https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/$(application_version)/jmx_prometheus_javaagent-$(application_version).jar

base_dir = /opt

application_dir = $(base_dir)/$(application)

application_user = prometheus
application_group = $(application_user)

package_filename = $(notdir $(download_url))
application_version_dir = $(base_dir)/$(basename $(package_filename))


.PHONY: $(application)
$(application):  download install config_install


.PHONY: adduser
adduser:
	@echo "Adding user $(application_user)..."
	@id -u $(application_user) &>/dev/null || useradd --system $(application_user)


.PHONY: dirs
dirs: adduser
	@echo "Creating $(application_dirs)..."
	@mkdir -p "$(application_version_dir)"
	@chown -R $(application_user):$(application_group) "$(application_version_dir)"


.PHONY: download
download:
	@echo "Downloading $(application) binary..."
	@curl --remote-time --progress-bar --location \
        --time-cond "$(package_filename)" -o "$(package_filename)" "$(download_url)"


.PHONY: config_install
config_install:
	@# copy configuration file
	@cp -f resources/config.yaml "$(application_dir)"


.PHONY: install
install: dirs adduser download
	@echo "Installing $(application) to $(application_dir_bin)"
	@cp -f $(package_filename) "$(application_version_dir)/$(application).jar"
	@chown -R $(application_user):$(application_group) "$(application_version_dir)"

	@rm -f "$(application_dir)"
	@ln -fs "$(application_version_dir)" "$(application_dir)"


.PHONY: clean
clean:
	@echo "Deleting downloaded jar files..."
	@rm -rf *.jar


.PHONY: distclean
distclean: clean
	@echo "Deleting  $(application) config files and directories ..."
	@rm -rf $(application_dir)
	@rm -rf $(application_version_dir)
	# @echo "Deleting user $(application_user)..."
	# @id -u $(application_user) &>/dev/null && userdel $(application_user) || echo -n ""