#!/bin/sh
ssh core@nuc1 mkdir -p coredns
scp -r Corefile zones core@nuc1:coredns
docker -H nuc1:2375 compose up -d
