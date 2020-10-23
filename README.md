# wgweb
simple webui for wireguard client configuration file - on top of pivpn

This is just a collection of scripts to make configuration done with pivpn available as webpages on a webserver.

### new_vpn_user.sh
`./new_vpn_user <client_name>`
* Runs `pivpn -a -n <client_name>`, 
* copies the configfile to webroot/clients/<client_name>
* makes a webpage at webroot/clients/<client_name>
* makes qrcode of the configuration file.
### remove_vpn_user.sh
`./remove_vpn_user <client_name>`
* Runs `pivpn -r <client_name>`
* removes config from webroot/clients/<client_name>
### nginx_wgweb.conf
Sample nginx configuration file for webserver.
You should probably also add some authentication to access the webinterface

