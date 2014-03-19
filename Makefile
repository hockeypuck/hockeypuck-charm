
MAKEDIR := $(shell pwd)

release:
	rm hooks/install
	sed 's/%%REPO%%/ppa/' hooks/install.pkg > hooks/install
	chmod +x hooks/install

unstable:
	rm hooks/install
	sed 's/%%REPO%%/unstable/' hooks/install.pkg > hooks/install
	chmod +x hooks/install

dev: files/hockeypuck files/instroot.tar.gz files/debian.tar.gz
	rm hooks/install
	cp hooks/install.dev hooks/install
	chmod +x hooks/install

files/hockeypuck:
	go build -o $@ launchpad.net/hockeypuck/cmd/hockeypuck

files/instroot.tar.gz:
	cd ../../../instroot; tar cvf $(MAKEDIR)/files/instroot.tar .
	cd ../../../instroot-extra; tar rvf $(MAKEDIR)/files/instroot.tar .
	gzip -9 files/instroot.tar

files/debian.tar.gz:
	cd ../../../debian; tar cvf $(MAKEDIR)/files/debian.tar .
	gzip -9 files/debian.tar

clean:
	$(RM) files/hockeypuck files/instroot.tar.gz

.PHONY: all clean
