.PHONY: all
all: minecraft prometheus grafana


.PHONY: minecraft
minecraft:
	$(MAKE) -C minecraft


.PHONY: prometheus
prometheus:
	$(MAKE) -C prometheus


.PHONY: grafana
grafana:
	$(MAKE) -C grafana


.PHONY: clean
clean:
	$(MAKE) -C minecraft clean
	$(MAKE) -C prometheus clean
	$(MAKE) -C grafana clean


.PHONY: distclean
distclean: clean
	$(MAKE) -C minecraft distclean
	$(MAKE) -C prometheus distclean
	$(MAKE) -C grafana distclean
