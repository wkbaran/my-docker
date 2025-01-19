## My Docker Stuff

The config files and scripts to create my various docker containers.

Current:
 - CoreDNS with static ip's and docker plugin, but ip's not exposed
 - Traefik routing via Host: header

*Use macvlan to expose container ip addresses*
```bash
core@nuc1:~$ docker network create -d macvlan   --subnet=192.168.50.0/24   --gateway=192.168.50.1   -o parent=eno1   macvlan_test
```

Test with
```bash
core@nuc1:~$ docker run --network=macvlan_test --ip=192.168.50.13 -d --name=test-macvlan nginx
```

I would like this network to be a separate subnet from my main network, but I don't know how to do the routing yet.

