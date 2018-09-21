#!/bin/bash

# REFERENCE: https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora

# Enterprise Linux and Fedora
# Including Red Hat® Enterprise Linux® / RHEL, CentOS and Fedora.
# Node.js is available from the NodeSource Enterprise Linux and Fedora binary distributions repository. Support for this repository, along with its scripts, can be found on GitHub at nodesource/distributions.
# Note that the Node.js packages for EL 5 (RHEL5 and CentOS 5) depend on the EPEL repository being available. The setup script will check and provide instructions if it is not installed.


## NodeSource Node.js Binary Distributions
## REFERENCE: https://github.com/nodesource/distributions

NODE_LATEST=0
# On RHEL, CentOS or Fedora, for Node.js v8 LTS:
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -

# Alternatively for Node.js 10:
if [ NODE_LATEST > 0 ]; then
   curl --silent --location https://rpm.nodesource.com/setup_10.x | sudo bash -
fi

# install:
sudo yum -y install nodejs
