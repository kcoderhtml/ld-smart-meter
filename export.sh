#!/bin/bash

export COLLECT_INFLUXDB_HOSTNAME=http://192.168.40.21:8086/
export COLLECT_INFLUXDB_TOKEN="-W9llNGQORpi67FpGj9_ssgWsgA_0d5Jee5mDU-hlPJ8MsN82JCz9m_gy29nA2Gyarm2xty5YO9L8l1m_Wrxhw=="
export COLLECT_INFLUXDB_ORG=smart-meter
export COLLECT_INFLUXDB_BUCKET=meter
export COLLECT_INFLUXDB_MEASUREMENT=utilities
export RTLAMR_FORMAT=json

rtlamr | rtlamr-collect