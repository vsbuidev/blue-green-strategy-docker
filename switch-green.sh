#!/bin/bash
set -e

# Configuration
GREEN_BACKEND_PORT=5000
PROXY_CONTAINER_NAME=proxy
NGINX_CONF_PATH=/etc/nginx/nginx.conf  # inside the container

echo "[INFO] Waiting for green backend health check..."
until curl -s http://localhost:$GREEN_BACKEND_PORT/health | grep -q "OK"; do
    echo "[...] Waiting for backend to be healthy..."
    sleep 3
done

echo "[✓] Green backend healthy. Switching proxy..."

# Modify nginx.conf inside the running proxy container
docker exec $PROXY_CONTAINER_NAME sed -i \
    -e 's/frontend-blue/frontend-green/g' \
    -e 's/backend-blue/backend-green/g' \
    $NGINX_CONF_PATH

echo "[INFO] Reloading proxy container..."
docker exec $PROXY_CONTAINER_NAME nginx -s reload

echo "[✅] Switched traffic to GREEN stack."
