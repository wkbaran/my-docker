#!/bin/sh
ssh core@nuc1.home mkdir -p frpc-n8n/certs
scp frpc.toml core@nuc1.home:frpc-n8n
scp certs/* core@nuc1.home:frpc-n8n/certs
docker -H nuc1.home:2375 compose up -d
