# cron refleshes the sas token every 60min. you must be able to run az command on the host
az iot hub generate-sas-token -n hub-apac-tokyo | jq -r .sas > sas.txt
