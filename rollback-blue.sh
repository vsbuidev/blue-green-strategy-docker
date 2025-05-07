#!/bin/bash

set -e
echo "[INFO] Rolling back to blue..."

sed -i 's/frontend-green/frontend-blue/g' ./proxy/nginx.conf
sed -i 's/backend-green/backend-blue/g' ./proxy/nginx.conf

docker restart proxy

echo "[DONE] Rolled back to BLUE."
