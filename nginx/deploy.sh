#!/bin/sh
ssh core@nuc1.home mkdir -p nginx
scp -r html core@nuc1.home:nginx
docker -H nuc1.home:2375 compose up -d
