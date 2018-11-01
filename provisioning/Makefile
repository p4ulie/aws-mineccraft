.PHONY: all
all: minecraft prometheus


.PHONY: minecraft
minecraft:
	$(MAKE) -C minecraft


.PHONY: prometheus
prometheus:
	$(MAKE) -C minecraft


.PHONY: clean
clean:
	$(MAKE) -C minecraft clean
	$(MAKE) -C prometheus clean

.PHONY: distclean
distclean: clean
	$(MAKE) -C minecraft distclean
	$(MAKE) -C prometheus distclean
