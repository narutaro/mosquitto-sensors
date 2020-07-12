azureApiVersion=2016-11-14
auzreSasToken=$(cat ./sas.txt)

iotGwName="tk10"

msg="{ \"id\": \"34323\", \"mid\": \"M_300108\", \"name\": \"60Min_W-PDU-I5E-A1 電圧R-S 計測\", \"time\": \"2020/05/01 09:00:00\", \"value\": \"414\", \"unit\": \"V\" }"

mosquitto_pub -d -q 1 \
  --capath /etc/ssl/certs/ \
  -V mqttv311 \
  -p 8883 \
  -h hub-apac-tokyo.azure-devices.net \
  -i iot-gw-$iotGwName \
  -u "hub-apac-tokyo.azure-devices.net/iot-gw-$iotGwName/api-version=${2016-11-14}" \
  -P "$auzreSasToken" \
  -t "devices/iot-gw-$iotGwName/messages/events/" \
  -m "$msg"
