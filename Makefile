# -*- Makefile -*-

BINDIR	= /usr/local/bin

.DEFAULT: install

install: $(BINDIR)/1pass

$(BINDIR)/1pass: 1pass
	cp -f 1pass $(BINDIR)/1pass
	chmod a+rx $(BINDIR)/1pass

uninstall:
	rm -f $(BINDIR)/1pass
