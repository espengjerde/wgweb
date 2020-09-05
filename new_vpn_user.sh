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
   echo "::  Add new user with QR-code, and make user ::"
   echo "::  configuration available at web directory ::"
   echo "::                                           ::"
   echo "::     new_vpn_user <client name>            ::"
   echo "::                                           ::"
   echo "==============================================="
}

if test $# -ne 1; then
	echo "Client name must be given. Missing input."
	helpFunc
	exit 1
fi
   CLIENT="$1"

cd $webroot
mkdir $CLIENT
cd $CLIENT

bash /opt/pivpn/wireguard/pivpn.sh -a -n ${CLIENT}

qrencode -t png -o $webroot/$CLIENT/$CLIENT.png < $wg_configs/$CLIENT.conf
qrencode -t ansiutf8 -o $webroot/$CLIENT/$CLIENT.txt < $wg_configs/$CLIENT.conf

cp $install_home/configs/$CLIENT.conf .
echo "creating HTML-file..."

echo "<html>
<head>
	<title>$CLIENT VPN details</title>
</head>
<body>
<h1>Getting the client software</h1>
<p>Download the Client from the <a href=\"https://wireguard.com/install/\">WireGuard Website</a></p>
<h1> $CLIENT vpn configuration </h1>
To set up the windows client, <a href=\"./$CLIENT.conf\">Download $CLIENT configuration file</a> and select this file in the wireguard agent. 
<h2> Config file</h2>
<pre>" >> index.html

cat ./$CLIENT.conf >> index.html

echo "</pre>
<h1> QR-code configuration</h1>
<p>Use these QR-codes to configure your Android or iOS device:</p>
<p><img src=\"./$CLIENT.png\">
<hr>
<pre>" >> index.html

#cat ./$CLIENT.txt >> index.html

echo "</pre>
</body>
</html>" >> index.html

