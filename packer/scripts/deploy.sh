#!/bin/bash

cd ~

mv puma.service /etc/systemd/system/puma.service
systemctl daemon-reload
systemctl enable puma.service

git clone -b monolith https://github.com/express42/reddit.git 
cd reddit && bundle install
puma -d
