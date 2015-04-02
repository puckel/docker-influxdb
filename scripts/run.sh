#!/bin/bash

set -m

CONFIG_FILE="/opt/influxdb/shared/config.toml"
URL="http://localhost:8086"
if [ "${PRE_CREATE_DB}" == "**None**" ]; then
    unset PRE_CREATE_DB
fi
if [ -n "${PRE_CREATE_DB}" ]; then
    echo "=> About to create the following database: ${PRE_CREATE_DB}"
    if [ -f "/.initial_db" ]; then
        echo "=> Database had been created before, skipping ..."
    else
        echo "=> Starting InfluxDB ..."
        exec /usr/bin/influxdb -config=${CONFIG_FILE} &
        PASS=${INFLUXDB_INIT_PWD:-root}
        arr=$(echo ${PRE_CREATE_DB} | tr ";" "\n")

        #wait for the startup of influxdb
        ST=1
        while [[ $ST -ne 0 ]]; do
            echo "=> Waiting for InfluxDB service startup ..."
            sleep 3 
            curl -k ${URL}/ping 2> /dev/null
            ST=$?
        done
        echo ""

        for x in $arr
        do
            echo "=> Creating database: ${x}"
            curl -s -k -X POST -d "{\"name\":\"${x}\"}" $(echo ${URL}'/db?u=root&p='${PASS}) 
        done
        echo ""

        touch "/.initial_db"
        fg
        exit 0
    fi
else
    echo "=> No database need to be pre-created"
fi

echo "=> Starting InfluxDB ..."

exec /usr/bin/influxdb -config=${CONFIG_FILE}
