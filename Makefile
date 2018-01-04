# -*- Makefile -*-

BINDIR	= /usr/local/bin

.DEFAULT: install

install: $(BINDIR)/1pass

$(BINDIR)/1pass: 1pass
	./install_files $(BINDIR) 1pass

uninstall:
	rm -f $(BINDIR)/1pass

release:
	$(MAKE) release-create
	$(MAKE) release-publish

release-create:
	@version=$(VERSION);					\
	if [[ "$$(git status --porcelain)" != "" ]]; then	\
		git status;					\
		echo "\nerror: Commit all changes first!" >&2;	\
		exit 1;						\
	fi;							\
	if [[ "$$version" == "" ]]; then			\
		git tag --column;				\
		echo "\nerror: Set VERSION variable!" >&2;	\
		exit 1;						\
	fi;							\
	echo "Releasing version $$version";			\
	git tag $$version
	$(MAKE) install

release-publish:
	git push
	git push --tags
