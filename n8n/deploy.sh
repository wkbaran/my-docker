#!/bin/sh
ssh core@nuc1.home mkdir -p n8n
docker -H nuc1.home:2375 compose up -d
