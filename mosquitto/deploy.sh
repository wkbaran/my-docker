#!/bin/sh

ssh core@nuc1.home mkdir -p mosquitto/config
ssh core@nuc1.home touch mosquitto/config/passwd
scp config/* core@nuc1.home:mosquitto/config
docker -H nuc1.home:2375 compose up -d
