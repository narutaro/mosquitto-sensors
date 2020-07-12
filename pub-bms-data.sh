#!/bin/bash
#
# Usage: pub-bms-data.sh bms-data.csv
#
# Supported csv format is: 34334,M_300510,60Min_W-PDU-I5E-B2 電力 計測,2020/06/01 00:00:00,29.2000007629395,kW
#

sendInterval=60

while read line
do

  json=$(echo $line | tr -d "\r" | jq -R 'split(",") | 
    {
      "id": .[0],
      "mid": .[1],
      "name": .[2],
      "time": .[3],
      "value": .[4],
      "unit": .[5]
    }
  ')

  azureApiVersion=2016-11-14
  auzreSasToken=$(cat ./sas.txt)

  iotGwName="tk10"

  mosquitto_pub -d -q 1 \
    --capath /etc/ssl/certs/ \
    -V mqttv311 \
    -p 8883 \
    -h hub-apac-tokyo.azure-devices.net \
    -i iot-gw-$iotGwName \
    -u "hub-apac-tokyo.azure-devices.net/iot-gw-$iotGwName/api-version=${2016-11-14}" \
    -P "$auzreSasToken" \
    -t "devices/iot-gw-$iotGwName/messages/events/" \
    -m "${json}"

  sleep ${sendInterval}

done < $1






