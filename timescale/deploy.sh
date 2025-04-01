#!/bin/sh
ssh core@nuc1.home mkdir -p time
scp -r init-data.sh core@nuc1.home:time
docker -H nuc1.home:2375 compose up -d
