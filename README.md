## My Docker Stuff

The config files and scripts to create my various docker containers.

Current:
 - CoreDNS with static ip's and docker plugin, but ip's not exposed
 - Supabase. Using supabase-db postgres server for n8n backend
 - n8n
 - Qdrant vector store
 - Jenkins
 - Nginx

Not currenlty using a reverse proxy. Docker host is in its own subnet via macvlan.  
Next time, try ipvlan instead.

*Using macvlan to expose container ip addresses*
```bash
core@nuc1:~$ docker network create -d macvlan   --subnet=192.168.50.0/24   --gateway=192.168.50.1   -o parent=eno1   macvlan_test
```
