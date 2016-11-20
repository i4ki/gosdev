#!/usr/bin/env nash

setenv GOROOT = "build/go"
setenv PATH = $GOROOT+"/bin:"+$PATH

go $ARGS
