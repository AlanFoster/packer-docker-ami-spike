#!/bin/bash

set -e -o pipefail

cd /opt/application
sudo docker build -t application:latest .

echo "sudo docker run -d --restart always -p 8000:80 application:latest" | sudo tee -a application.sh
