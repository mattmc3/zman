.DEFAULT_GOAL := help

.PHONY: test
test:
	./bin/runtests

.PHONY: zmandata
zmandata:
	./bin/gen_zmandata

.PHONY: help
help:
	@echo "Usage:  make <command>"
	@echo ""
	@echo "Commands:"
	@echo "  help       shows this message"
	@echo "  zmandata  make data file for zman"
	@echo "  test       run unit tests"
