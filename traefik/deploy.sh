#!/bin/sh
ssh core@nuc1.home mkdir -p traefik/config
scp -r traefik.yml core@nuc1.home:traefik
docker -H nuc1.home:2375 compose up -d
