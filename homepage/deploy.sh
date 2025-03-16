#!/bin/sh
ssh core@nuc1.home mkdir -p homepage/config homepage/public/icons
scp config/settings.yaml config/services.yaml core@nuc1.home:homepage/config
scp public/icons/* core@nuc1.home:homepage/public/icons
docker -H nuc1.home:2375 compose up -d
