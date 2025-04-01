#!/bin/sh
ssh core@nuc1.home mkdir -p timescale
scp -r init-data.sh postgresql.conf core@nuc1.home:timescale
docker -H nuc1.home:2375 compose up -d
