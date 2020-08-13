#!/bin/sh

UPDATE_RULES_TIME=${UPDATE_RULES_TIME:-"0 8 * * *"}

echo "update rules time definition: ${UPDATE_RULES_TIME}"

trap "bye" HUP INT QUIT TERM

bye() {
    echo "exiting..."
    exit 0
}

run_v2ray() {
    v2ray -c /etc/v2ray/config.json
}

echo "${UPDATE_RULES_TIME} update_rules.sh ${V2RAY_PATH} >> /tmp/update_rules.log 2>&1" >> /var/spool/cron/crontabs/root

/usr/sbin/crond


while :
do
    run_v2ray
    sleep 3
done