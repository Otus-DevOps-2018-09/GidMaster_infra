testapp_IP = 35.205.184.252
testapp_port = 9292

# GidMaster_infra
GidMaster Infra repository

Home assignment #4:

Additional tasks solution:

1. Make configuration for puma-server using gcloud CLI to run VM instance with startup script:
```
  sudo gcloud compute instances create reddit-app-startup-script \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --metadata-from-file \
  startup-script=startup-script.sh \
  --restart-on-failure \
```  

2.  Make firewall rule default-puma-server for puma-server using gcloud CLI
```
  sudo gcloud compute firewall-rules create default-puma-server \
  --action allow \
  --source-ranges 0.0.0.0/0 \
  --target-tags puma-server \
  --rules tcp:9292 \
  --direction INGRESS \
```
