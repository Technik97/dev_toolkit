#!/usr/bin/env bash
set -e

IMAGE_NAME="jackal"
TAG="latest"

echo "Building Docker image: $IMAGE_NAME:$TAG"
docker build -t "$IMAGE_NAME:$TAG" .

echo "Done. Run with: docker run --rm $IMAGE_NAME"
