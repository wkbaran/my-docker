#!/bin/sh
ssh core@nuc1.home mkdir -p supabase
scp -r init-data.sh core@nuc1.home:psql
docker -H nuc1.home:2375 compose up -d
