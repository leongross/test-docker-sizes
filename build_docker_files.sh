#!/usr/bin/env bash

registry=ghcr.io
username=leongross
repo=test-docker-sizes

upstream="$registry/$username/$repo"

# baes fie size in bytes
file_sizes=(10000 10000000 100000000)

echo "Generating payloads"
for i in "${file_sizes[@]}";do
    echo "[*] Payload size = $i"
    dd if=/dev/zero of=file_"$i".bin bs=1 count=$i

    DOCKER_BUILDKIT=1 \
    docker build \
        --build-arg TAG=file_"$i" \
        -t "$upstream":"$i" \
        .
    
    docker push "$upstream:$i"
done


