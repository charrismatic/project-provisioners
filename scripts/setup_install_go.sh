#!/bin/bash

#https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz
mkdir ./tmp
cd tmp
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
mv go ../go
cd ..
cd ..
rm -rf .temp/
cd go/


# https://golang.org/doc/install
#  choose the archive file appropriate for your installation. For instance, if you are installing Go version 1.2.1 for 64-bit x86 on Linux, the archive you want is called go1.2.1.linux-amd64.tar.gz.
# (Typically these commands must be run as root or through sudo.)

#Add /usr/local/go/bin to the PATH environment variable. You can do this by adding this line to your /etc/profile (for a system-wide installation) or $HOME/.profile:

### export GOROOT=$HOME/go1.X
### export PATH=$PATH:$GOROOT/bin
### 

# export PATH=$PATH:/$HOME/go/bin
# go get github.com/golang/example/hello
