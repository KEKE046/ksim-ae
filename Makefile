.phony: build clean-build run clean-run

build:
	$(MAKE) -C runs build
clean-build:
	$(MAKE) -C runs clean

run-all: run results/cpu-info.json results/size.csv

run:
	python benchmark.py
clean-run:
	rm -rf results

results/cpu-info.json:
	lscpu -J > $@
results/size.csv:
	$(MAKE) -C count-size

.phony: prepare-setup setup distclean

prepare-setup: prepare-setup-sims prepare-setup-tools
prepare-setup-%:
	$(MAKE) -C $* prepare

setup: setup-sims setup-tools
setup-%:
	$(MAKE) -C $* setup

distclean:
	$(MAKE) -C sims clean
	$(MAKE) -C tools clean
	$(MAKE) -C runs clean