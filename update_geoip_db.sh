#!/bin/bash

# name of deluge Docker container
CONTAINER="deluge"

DOCKER=$(which docker)
WGET=$(which wget)

# download IPv4 GeoIP database
echo -n " => Downloading IPv4 GeoIP database... "
$WGET -q http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
echo "done!"

# download IPv6 GeoIP database
echo -n " => Downloading IPv6 GeoIP database... "
$WGET -q http://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz
echo "done!"

echo -n " => Extracting and copying databases into container... "
gunzip GeoIP.dat.gz GeoIPv6.dat.gz
$DOCKER cp GeoIP.dat   $CONTAINER:/usr/share/GeoIP/GeoIP.dat > /dev/null 2>&1
$DOCKER cp GeoIPv6.dat $CONTAINER:/usr/share/GeoIP/GeoIPv6.dat > /dev/null 2>&1
echo "done!"

# clean up local database files
rm -f GeoIP*.dat
