.PHONY: all
all: prometheus node_exporter


.PHONY: prometheus
prometheus:
	$(MAKE) -C prometheus


.PHONY: node_exporter
node_exporter:
	$(MAKE) -C node_exporter


.PHONY: clean
clean:
	$(MAKE) -C node_exporter clean
	$(MAKE) -C prometheus clean


.PHONY: distclean
distclean: clean
	$(MAKE) -C node_exporter distclean
	$(MAKE) -C prometheus distclean
