.PHONY: all
all: prometheus node_exporter jmx_exporter # alertmanager


.PHONY: prometheus
prometheus:
	$(MAKE) -C prometheus


.PHONY: node_exporter
node_exporter:
	$(MAKE) -C node_exporter


.PHONY: jmx_exporter
jmx_exporter:
	$(MAKE) -C jmx_exporter


.PHONY: alertmanager
alertmanager:
	$(MAKE) -C alertmanager


.PHONY: clean
clean:
	$(MAKE) -C node_exporter clean
	$(MAKE) -C jmx_exporter clean
#	$(MAKE) -C alertmanager clean
	$(MAKE) -C prometheus clean


.PHONY: distclean
distclean: clean
	$(MAKE) -C node_exporter distclean
	$(MAKE) -C jmx_exporter distclean
#	$(MAKE) -C alertmanager distclean
	$(MAKE) -C prometheus distclean
