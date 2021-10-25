#!/bin/bash
docker exec -ti new-openvpn easyrsa build-client-full $1 nopass
docker exec -ti new-openvpn ovpn_getclient $1 > ./vpn_files/$1.ovpn
