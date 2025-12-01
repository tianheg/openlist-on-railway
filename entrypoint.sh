#!/bin/sh

echo "🔧 Fixing permissions for Railway volume..."

mkdir -p /opt/openlist/data

if [ "$(id -u)" = "0" ]; then
    chown -R 1001:1001 /opt/openlist/data
    chmod -R 755 /opt/openlist/data
    
    echo "✅ Permissions fixed for UID 1001"

    exec su-exec 1001:1001 "$@"
else
    echo "⚠️ Not running as root, skipping permission fix"
    exec "$@"
fi
