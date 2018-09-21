# https://golang.org/dl/
# https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz

mkdir ~/gotmp & cd ~/gotmp

# Download the archive
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz

## tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
tar -xzf go1.10.3.linux-amd64.tar.gz

#  extract it into /usr/local, creating a Go tree in /usr/local/go.

sudo mv ./go /usr/local/go

cd ~
rm -rf ~/gotmp


# (Typically these commands must be run as root or through sudo.)
# Add /usr/local/go/bin to the
# PATH environment variable.
# You can do this by adding this line to your /etc/profile
# (for a system-wide installation) or $HOME/.profile:


GO_STABLE="1.10.3"

# https://golang.org/doc/install

# Add /usr/local/go/bin to the PATH environment variable.
# You can do this by adding this line to your /etc/profile
# (for a system-wide installation) or $HOME/.profile:

## PROGRAM BIN FOLDERS FOR NPM
# ```
#    if [ -d $HOME/nodejs/bin ] ; then
#      PATH=$HOME/nodejs/bin:$PATH
#    fi
#  # OR
#    if [ -d /usr/local/go/bin ] ; then
#      PATH=/usr/local/go/bin:$PATH
#    fi
# ```
#
# Installing to a custom location
# The Go binary distributions assume they will be installed in /usr/local/go (or c:\Go under Windows), but it is possible to install the Go tools to a different location. In this case you must set the GOROOT environment variable to point to the directory in which it was installed.
# For example, if you installed Go to your home directory you should add commands like the following to $HOME/.profile:


#export GOROOT=$HOME/go1.X
#export PATH=$PATH:$GOROOT/bin
#Note: GOROOT must be set only when installing to a custom location.

# export GOROOT=$HOME/go1.X
# export PATH=$PATH:$GOROOT/bin

# export PATH=$PATH:/$HOME/go/bin
# go get github.com/golang/example/hello
