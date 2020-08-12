#!/bin/sh

trap "bye" HUP INT QUIT TERM

bye() {
    echo "exiting..."
    exit 0
}

/usr/sbin/crond

v2ray

while :
do
    sleep 10
done