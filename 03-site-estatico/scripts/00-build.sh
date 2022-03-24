#!/bin/sh

set -e

cd "${0%/*}" || return

echo "----------------------------------------"
echo "Creating an optimized production React App build..."
cd ../website || return
docker run -itd --name webapp -v $(pwd):/opt/app-root/src -p 3000:3000 node:14-alpine
docker exec -u root webapp sh -c "cd /opt/app-root/src/ && npm ci && npm run build"
docker stop webapp && docker rm webapp
echo "----------------------------------------"
