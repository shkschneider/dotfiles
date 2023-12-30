PREFIX ?= /usr/local

.PHONY: all
all:
	@echo "Nothing to do."

.PHONY: install
install:
	@echo bash ./dot
	@echo install -Dm4655 ./cli/.local/bin/pm $(PREFIX)/bin/pm

.PHONY: uninstall
uninstall:
	@echo rm -f $(PREFIX)/bin/pm
