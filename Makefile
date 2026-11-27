PREFIX ?= /usr/local
pkgdir = $(DESTDIR)$(PREFIX)/lib/tpersist-sqlite0.1.9

.PHONY: install
install:
	install -d "$(pkgdir)"
	install -m 644 pkgIndex.tcl sqlite.tcl LICENSE "$(pkgdir)"
