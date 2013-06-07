#!/bin/bash
#--------------------------------------------------------------------
# BOOTSTRAP Variables
#--------------------------------------------------------------------
# These variables can be used by the recipes
export BOOTSTRAP_HOST=gmw-gorozco1.zpn.intel.com
export BOOTSTRAP_URL=http://$BOOTSTRAP_HOST/oc-bootstrap
export BOOTSTRAP_RECIPES_URL=http://$BOOTSTRAP_HOST/oc-bootstrap/recipes/
# Local variables for the bootstrap 
# Very important to set the recipes to run in the order you want to run
# These variables can only be used by the bootstrap
# RECIPES="recipe1 recipe2"
RECIPES="os-repo" # Recipes to retrieve
DISTRO_AND_VERSION=`wget -qO- $BOOTSTRAP_URL/tools/os_detect.sh | bash | tr ' ' '/'` # Detect Distro and Version
export REPO_URL=
#--------------------------------------------------------------------
# RECIPES Variables
# if you want to overwrite the default variable value they have already
# Add your recipes variables,values here 
#--------------------------------------------------------------------
# change-admin-pwd recipe variable (embedded here)
# export ADMIN_PWD=rootroot
# os-repo recipe variables
export OS_REPO=http://repo-eg01.cps.intel.com/archive.ubuntu.com/
# puppet-repo recipe variables
# export PUPPET_REPO=http://repo-eg01.cps.intel.com/apt.puppetlabs.com/
# export PUPPET_KEY=http://$BOOTSTRAP_HOST/oc-bootstrap/recipes/puppet-repo/common/puppetlabs-pubkey.gpg
# puppet-agent recipe variables
# export PUPPET_PACKAGE=3.1.1-1puppetlabs1
# proxy recipe & system bootstrap variables
# export http_proxy=http://proxy-us.intel.com:911
# export https_proxy=http://proxy-us.intel.com:911
# export socks_proxy=socks://proxy-skype.intel.com:1080/
# export ftp_proxy=
export no_proxy=localhost,127.0.0.1,`hostname -f`,$BOOTSTRAP_HOST,.intel.com,.local,$no_proxy
#--------------------------------------------------------------------
# NO TUNABLES BELOW THIS POINT
#--------------------------------------------------------------------
if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi
# Micro minimal recipe that must be applied in the heart of the bootstrap
# Setting root pwd from the very beggining
if [ ! -z "$ADMIN_PWD" ]; then
    echo root:$ADMIN_PWD | chpasswd 
fi

# This is a chicken and the egg problem.. we cannot get curl installed
# because we haven't set the local repos ;-), other option will be to
# cook curl in the images already but the Vagrant boxes does not have it
# by default :-(
#
# Installing curl if we don't have it
# [[ -z `which curl` ]] && apt-get install -y curl >/dev/null
# So the wget instructions can be curl instead

# Loop on the recipes to run
for recipe in $RECIPES
do
    wget -qO- "${BOOTSTRAP_RECIPES_URL}/${recipe}/os/${DISTRO_AND_VERSION}/init.sh" | bash
done
#kill -HUP `cat /proc/1111/status | grep PPid | awk '{print $2}'`
