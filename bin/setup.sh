#!/usr/bin/env nash

GOOS <= uname | tr "[:upper:]" "[:lower:]"

GOARCH = "amd64"

mkdir -p build

fn download(url, location) {
	-test -d $location

	if $status == "0" {
		return
	}

	-test -f build/go.tar.gz

	if $status != "0" {
		wget -c $url -O build/go.tar.gz
	}

	tar xvf build/go.tar.gz -C build

	if $location != "" {
		mv build/go $location
	}

	rm build/go.tar.gz
}

fn getbootstrap() {
	GOVERSION = "1.6.3"
	url       = "https://storage.googleapis.com/golang/go"+$GOVERSION+"."+$GOOS+"-"+$GOARCH+".tar.gz"

	download($url, "build/go_bootstrap")
}

fn getgo() {
	-test -d build/go

	if $status == "0" {
		return
	}

	GOVERSION = "go1.7.3"

	git clone --depth 1 --branch $GOVERSION https://github.com/golang/go build/go
}

getbootstrap()
getgo()
