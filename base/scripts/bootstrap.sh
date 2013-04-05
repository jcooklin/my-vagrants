#!/bin/bash
# set -e 
REPO=repo-eg01.cps.intel.com
UBUNTU=0
SLES=0
set_intel_proxy()
{
    # Set Intel Proxy
    echo "Setting Intel Proxy..."
    echo 'Acquire::http::Proxy "http://proxy-us.intel.com:911";' > /etc/apt/apt.conf
}
set_distro_repo() 
{
    if [ $UBUNTU -eq 1 ]; then
        # Set Intel Ubuntu Repo 
        #echo "Configuring Intel Ubuntu repo"
        #mv /etc/apt/sources.list /etc/apt/sources.orig
        #sed -e "s/us.archive.ubuntu.com/$REPO\/archive.ubuntu.com/g" -e "s/security.ubuntu.com/$REPO\/archive.ubuntu.com/g" /etc/apt/sources.orig > /etc/apt/sources.list
        # Disable downloading translations
        echo "Acquire::Languages \"none\";" > /etc/apt/apt.conf.d/99translations
        echo "Initial apt-get update...."
        apt-get update >/dev/null
    elif [ $SLES -eq 1 ]; then
        # Set Intel Ubuntu Repo 
        echo "Configuring Intel SLES repo"
    else 
        # Distro not supported 
        echo "Distro not supported"
        exit 0
    fi

}

set_puppet_repo() 
{
    if [ $UBUNTU -eq 1 ]; then
        # Set Intel Puppetlabs repo
        echo "Configuring Intel PuppetLabs repo"
        #echo -e "deb http://$REPO/apt.puppetlabs.com/ ${DISTRIB_CODENAME} main\ndeb-src http://$REPO/apt.puppetlabs.com/ ${DISTRIB_CODENAME} main" > /etc/apt/sources.list.d/puppet.list
        echo -e "deb http://apt.puppetlabs.com/ ${DISTRIB_CODENAME} main\ndeb-src http://apt.puppetlabs.com/ ${DISTRIB_CODENAME} main" > /etc/apt/sources.list.d/puppet.list
        echo "Importing PuppetLabs key..."
        apt-key adv --keyserver keyserver.ubuntu.com --keyserver-options http-proxy=http://proxy.jf.intel.com:911/ --recv 4BD6EC30
        apt-get update >/dev/null
    elif [ $SLES -eq 1 ]; then
        # Set Intel Ubuntu Repo 
        echo "Configuring Intel SLES repo"
    else 
        # Distro not supported 
        echo "Distro not supported"
        exit 0
    fi
}

install_puppet()
{
    if [ $UBUNTU -eq 1 ]; then
        # Install Puppet
        echo "Installing Puppet 3.1.1-1puppetlabs1 ..."
        apt-get install -y puppet=3.1.1-1puppetlabs1 >/dev/null

        echo "Puppet installed!"
    elif [ $SLES -eq 1 ]; then
        # Set Intel Ubuntu Repo 
        echo "Configuring Intel SLES repo"
    else 
        # Distro not supported 
        echo "Distro not supported"
        exit 1
    fi
}

#--------------------------------------------------------------------
# NO TUNABLES BELOW THIS POINT
#--------------------------------------------------------------------
if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Check which system this script is running
if [ -f /etc/lsb-release ]; then
    # Load up the release information
    . /etc/lsb-release
    if [ "$DISTRIB_ID" == "Ubuntu" ]; then
       UBUNTU=1
    fi
fi
set_intel_proxy
set_distro_repo
set_puppet_repo
install_puppet
