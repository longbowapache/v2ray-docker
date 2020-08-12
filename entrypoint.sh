#!/bin/sh

trap "bye" HUP INT QUIT TERM

bye() {
    echo "exiting..."
    exit 0
}

run_v2ray() {
    v2ray -c /etc/v2ray/config.json
}

/usr/sbin/crond


while :
do
    run_v2ray
    sleep 3
done