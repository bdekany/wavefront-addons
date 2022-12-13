#!/bin/bash

if [[ -z $WAVEFRONT_TOKEN || -z $WAVEFRONT_ADDRESS ]] ; then
  printf 'Error: WAVEFRONT_TOKEN or WAVEFRONT_ADDRESS is not set\n' 1>&2
  exit
fi

declare -a ids
ids=(
Application-View
App-Releases-Dashboard
Platform-View
Service-Dashboard-cluster-info
SLI-SLO-Dashboard
AOA-Start
AOA-High-Level-Demo
AOA-High-Level-Demo-Section-1
AOA-High-Level-Demo-Section-2
AOA-High-Level-Demo-Section-3
AOA-High-Level-Demo-Section-4
AOA-High-Level-Demo-Section-5
)

for id in ${ids[@]}; do

printf 'Download %s: ' ${id}

curl -s -X 'GET' https://${WAVEFRONT_ADDRESS}/api/v2/dashboard/${id} \
  -H "Authorization: Bearer ${WAVEFRONT_TOKEN}" \
  -H 'accept: application/json' | jq -M ".response" > ${id}.json

printf 'OK\n'
done
