.DEFAULT_GOAL := help

.PHONY: test
test:
	./bin/runtests

.PHONY: zdocsdata
zdocsdata:
	./bin/gen_zdocsdata

.PHONY: help
help:
	@echo "Usage:  make <command>"
	@echo ""
	@echo "Commands:"
	@echo "  help       shows this message"
	@echo "  zdocsdata  make data file for zdocs"
	@echo "  test       run unit tests"
