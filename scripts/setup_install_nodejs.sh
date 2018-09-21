#!/bin/sh
## echo $SHELL if unknown

## HOW TO INSTALL 
# https://www.a2hosting.com/kb/installable-applications/manual-installations/installing-node-js-on-managed-hosting-accounts
## LEGACY NODEJS 9.0
# wget https://nodejs.org/dist/v9.2.0/node-v9.2.0-linux-x64.tar.xz

NPM_VERSION=${1:-"STABLE"}
INSTALL_MODE=${2:-"USER"}
INSTALL_ENV=${2:-"DEBIAN"} # ubuntu/debian | rhel

NPM_DIST=linux-x64

NPM_STABLE_VERSION=v8.11.4
NPM_STABLE_RELEASE=node-$NPM_STABLE_VERSION-$NPM_DIST # node-v8.11.4-linux-x64

NPM_EDGE_VERSION=v9.4.0
NPM_EDGE_RELEASE=node-$NPM_EDGE_VERSION-$NPM_DIST

NPM_PRODUCTION_RELEASE=
NPM_PRODUCTION_VERSION=


install_node_rhel_production () {


# REFERENCE: https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora

    # Enterprise Linux and Fedora
    # Including Red Hat® Enterprise Linux® / RHEL, CentOS and Fedora.
    # Node.js is available from the NodeSource Enterprise Linux and Fedora binary distributions repository.
    # Support for this repository, along with its scripts, can be found on GitHub at nodesource/distributions.
    # Note that the Node.js packages for EL 5 (RHEL5 and CentOS 5) depend on the EPEL repository being available. 
    # The setup script will check and provide instructions if it is not installed.

    ## NodeSource Node.js Binary Distributions
    ## REFERENCE: https://github.com/nodesource/distributions

    NODE_LATEST=${1:-0}
    NPM_LATEST_VERSION="setup_10.x"
    NPM_VERSION="setup_8.x"

    # On RHEL, CentOS or Fedora, for Node.js v8 LTS:
    curl --silent --location https://rpm.nodesource.com/$NPM_VERSION | sudo bash -

    # Alternatively for Node.js 10:
    if [ $NODE_LATEST > 0 ]; then
       curl --silent --location https://rpm.nodesource.com/$NPM_LATEST_VERSION | sudo bash -
    fi

    sudo yum -y install nodejs
}


install_node_debian_production () {
    NODE_LATEST=${1:-0}
    NPM_LATEST_VERSION="setup_10.x"
    NPM_VERSION="setup_6.x"

    curl -sL https://deb.nodesource.com/$NPM_VERSION -o $HOME/nodesource_setup.sh        

    if [ $NODE_LATEST > 0 ]; then
       curl --silent --location https://deb.nodesource.com/$NPM_LATEST_VERSION | sudo bash -
    fi    

    chmod +x $HOME/nodesource_setup.sh
    sh $HOME/nodesource_setup.sh
    apt-get install nodejs -y 
}



if [ "$NPM_VERSION" = "PRODUCTION" ] 

    if [ "$INSTALL_ENV" = "RHEL" ]  
    
        install_node_rhel_production

    else 
        install_node_debian_production
    fi 

    exit 0

else 
    mkdir $HOME/nodejs 
    mkdir $HOME/nodejs_temp 
    cd $HOME/nodejs_temp 

    if [ "$NPM_VERSION" = "STABLE" ]; then
        NPM_INSTALLED_VERSION=$NPM_STABLE_VERSION
        NPM_INSTALLED_NAME=$NPM_STABLE_RELEASE

        wget https://nodejs.org/dist/$NPM_STABLE_VERSION/$NPM_INSTALLED.tar.xz
        tar -xJf $NPM_INSTALLED.tar.xz 
        mv $NPM_INSTALLED/* $HOME/nodejs
    else            
        NPM_INSTALLED_VERSION=$NPM_EDGE_VERSION
        NPM_INSTALLED_NAME=$NPM_EDGE_RELEASE

        wget https://nodejs.org/dist/$NPM_EDGE_VERSION/$NPM_EDGE_RELEASE.tar.xz
        tar -xJf $NPM_EDGE_RELEASE.tar.gz
        mv $NPM_EDGE_RELEASE/* $HOME/nodejs
    fi

    cd $HOME/nodejs 
    rm -rf $HOME/nodejs_temp   

    if [ "$INSTALL_MODE" = "SYSTEM" ]; then
        mv $NPM_INSTALLED_NAME /usr/local/nodejs
    else 
        ln -s $HOME/nodejs/bin/npm $HOME/bin/npm
        ln -s $HOME/nodejs/bin/node $HOME/bin/node
    fi 

    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'
fi  


    

    


