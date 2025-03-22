#!/bin/sh

sed -i "s/FAULT_PERCENTAGE_PLACEHOLDER/${FAULT_PERCENTAGE:-0}/" /etc/envoy/envoy.yaml
sed -i "s/PORT_PLACEHOLDER/${BACKEND_PORT:-80}/" /etc/envoy/envoy.yaml
exec envoy -c /etc/envoy/envoy.yaml