.DEFAULT_GOAL := help

.PHONY: test
test:
	./bin/runtests

.PHONY: refreshdata
refreshdata:
	./bin/zmandata --refresh

.PHONY: datafile
datafile:
	./bin/zmandata

.PHONY: pipup
pipup:
	./bin/zmandata --pipup

.PHONY: help
help:
	@echo "Usage:  make <command>"
	@echo ""
	@echo "Commands:"
	@echo "  help          shows this message"
	@echo "  datafile      make data file for zman"
	@echo "  pipup         update python libs for zmandata utility"
	@echo "  refreshdata   make data file for zman from latest data"
	@echo "  test          run unit tests"
