#!/bin/bash

docker exec proxy sed -i \
  -e 's/frontend-green/frontend-blue/g' \
  -e 's/backend-green/backend-blue/g' \
  /etc/nginx/nginx.conf

docker exec proxy nginx -s reload

echo "[↩] Rolled back to Blue."
