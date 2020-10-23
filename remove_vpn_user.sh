#!/bin/bash

if [ $(whoami) != root ]; then
    echo "Please run as root"
    exit 1
fi

pivpn_setup_vars="/etc/pivpn/wireguard/setupVars.conf"
webroot="/var/www/html/clients"
wg_configs="/etc/wireguard/configs/"

if [ ! -f "${pivpn_setup_vars}" ]; then
    echo "::: Missing setup vars file!"
    exit 1
fi

source "$pivpn_setup_vars"

helpFunc()  {
   echo "==============================================="
   echo ":: Delete users from wireguard community and ::"
   echo "::  remove configuration from web directory  ::"
   echo "::                                           ::"
   echo "::  remove_vpn_user <client name>            ::"
   echo "::                                           ::"
   echo "==============================================="
}

if test $# -ne 1; then
        echo "Client name must be given. Missing input."
        helpFunc
        exit 1
fi
   CLIENT="$1"

if pivpn -l | grep $CLIENT; then
    bash /opt/pivpn/wireguard/pivpn.sh -r ${CLIENT}
    cd $webroot
    rm -rf $CLIENT
    echo "::: Deleted $CLIENT folder from webui"
else
    echo "User $CLIENT not found. Listing users:"
    pivpn -l
fi
