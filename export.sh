#!/bin/bash

export COLLECT_INFLUXDB_HOSTNAME=http://192.168.40.21:8086/
export COLLECT_INFLUXDB_TOKEN="0wKsG6IUvV_5yeqNA9YR5P5PAZP_kH9etNZPDPaqf9CirmNpMBETgwYwz_ZfqJ_7QM8UAV0k7_ujdPrAOSfDXg=="
export COLLECT_INFLUXDB_ORG=smart-meter
export COLLECT_INFLUXDB_BUCKET=meter
export COLLECT_INFLUXDB_MEASUREMENT=utilities
export RTLAMR_FORMAT=json

rtlamr | rtlamr-collect