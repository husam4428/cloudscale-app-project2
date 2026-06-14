#!/bin/bash
apt update -y
apt install docker.io -y
systemctl enable docker
systemctl start docker

# تشغيل حاويتك الخاصة بالمشروع تلقائياً
docker run -d --restart always -p 80:80 husam4428/cloudscale-app:v1
