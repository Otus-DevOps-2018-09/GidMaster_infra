#!/bin/bash
gcloud compute instances create reddit-app-full\
  --boot-disk-size=10GB \
  --image-family reddit-full \
  --image-project=nfra-219309 \
  --machine-type=f1-micro \
  --tags puma-server \
  --restart-on-failure \
  --zone=europe-west1-d
  