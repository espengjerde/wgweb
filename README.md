# wgweb
simple webui for wireguard client configuration file - on top of pivpn

This is just a collection of scripts to make configuration done with pivpn available as webpages on a webserver.

### new_vpn_user.sh
`./new_vpn_user <client_name>`
* Runs `pivpn -a -n <client_name>`, 
* copies the configfile to webroot/clients/<client_name>
* makes a webpage at webroot/clients/<client_name>
* makes qrcode of the configuration file.

