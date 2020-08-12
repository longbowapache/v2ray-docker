#!/bin/sh

if [ -z "$1" ]; then
    echo "please specify v2ray geoip/geosite directory as only parameter"
    exit 1
fi

V2RAY_DIR=$1
echo "V2ray Dir: $V2RAY_DIR"

cd /tmp/ && { curl -L -H "Cache-Control: no-cache" -o geoip.dat https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geoip.dat; cd - > /dev/null; }
cd /tmp/ && { curl -L -H "Cache-Control: no-cache" -o geosite.dat https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/geosite.dat; cd - > /dev/null; }

if [ -f /tmp/geoip.dat ] && [ -f /tmp/geosite.dat ]; then
    echo "copy to $V2RAY_DIR"
    cp /tmp/geoip.dat $V2RAY_DIR
    cp /tmp/geosite.dat $V2RAY_DIR
    pkill v2ray
fi

[ -f /tmp/geoip.dat ] && rm /tmp/geoip.dat
[ -f /tmp/geosite.dat ] && rm /tmp/geosite.dat
