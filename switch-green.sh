#!/bin/bash

set -e

echo "[INFO] Checking green backend health..."
if curl -s http://localhost:5000/health | grep "OK"; then
    echo "[OK] Green backend healthy. Switching traffic..."

    sed -i 's/frontend-blue/frontend-green/g' ./proxy/nginx.conf
    sed -i 's/backend-blue/backend-green/g' ./proxy/nginx.conf

    docker restart proxy

    echo "[DONE] Traffic now routed to GREEN."
else
    echo "[FAIL] Green backend is not healthy. Aborting switch."
    exit 1
fi
