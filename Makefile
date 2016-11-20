.PHONY: clean setup patch build test update-stdlib unpatch

NASHURL  	 := "https://github.com/NeowayLabs/nash/releases/download/v0.2/nash"
GOROOT_BOOTSTRAP := $(abspath build/go_bootstrap)
GOROOT           := $(abspath build/go)

PATCHES = $(shell find `pwd`/patches -name "*.diff")

all: clean setup patch build test

build: $(GOROOT)/bin/osdev.sh $(GOROOT)/bin/go update-stdlib
	deps/nash $(GOROOT)/bin/osdev.sh build -a runtime

$(GOROOT)/bin/osdev.sh:
	cp bin/osdev.sh "$@"

$(GOROOT)/bin/go:
	cd $(GOROOT)/src && \
	env GOROOT_BOOTSTRAP=$(GOROOT_BOOTSTRAP) CGO_ENABLED=0 ./make.bash
clean:
	rm -rf build

setup: deps/nash build/go
build/go:
	./deps/nash ./bin/setup.sh

deps/nash:
	mkdir -p deps
	wget $(NASHURL) -O deps/nash
	chmod "+x" deps/nash

update-stdlib:
	cd $(GOROOT) && git clean -q -df -- src/
	rsync -a src/ $(GOROOT)/src/

patch:
	cd $(GOROOT) && git apply $(PATCHES)

unpatch:
	cd $(GOROOT) && git apply -R $(PATCHES)
