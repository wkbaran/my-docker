#!/bin/sh
#ssh core@nuc1.home mkdir -p jenkins
#scp -r init-data.sh core@nuc1.home:jenkins
docker -H nuc1.home:2375 compose up -d
