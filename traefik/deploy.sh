#!/bin/sh
ssh core@nuc1 mkdir -p traefik/config
scp -r traefik.yml core@nuc1:traefik
docker -H nuc1:2375 compose up -d
