#!/bin/sh
ssh core@nuc1.home mkdir -p coredns
scp -r Corefile core@nuc1.home:coredns
docker -H nuc1.home:2375 compose up -d
