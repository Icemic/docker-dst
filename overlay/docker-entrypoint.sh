#! /bin/sh

set -e


# Create config directories
if [ ! -d "/dst/DoNotStarveTogether/Cluster_1" ]; then
    mkdir -p /dst/DoNotStarveTogether/Cluster_1
fi

# Copy default configuration files
if [ ! -f "/dst/DoNotStarveTogether/Cluster_1/cluster.ini" ]; then
    cp /defaults/cluster.ini /dst/DoNotStarveTogether/Cluster_1/cluster.ini
fi

# Ensure cluster token file exists
touch /dst/DoNotStarveTogether/Cluster_1/cluster_token.txt

# Make server files writable by other users
chmod -R a+rw /dst

exec "$@"
