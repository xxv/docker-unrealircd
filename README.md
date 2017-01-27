# usage

  docker run xxv/docker-unrealircd
  
UnrealIRCD
==========

Differences from the upstream:

* Removes Anope (services)
* Allows non-SSL connections

Container
------

```
docker stop unrealircd
docker rm unrealircd

docker build -t unrealircd .

docker run --restart=always --name unrealircd \
  -p 6666:6666 -p 6667:6667 -p 6697:6697 -p 8097:8097 -d \
  -v /opt/unrealircd/ssl/server.cert.pem:/home/ircd/unrealircd/conf/ssl/server.cert.pem \
  -v /opt/unrealircd/ssl/server.key.pem:/home/ircd/unrealircd/conf/ssl/server.key.pem \
  -v /opt/unrealircd/unrealircd.conf:/home/ircd/unrealircd/conf/unrealircd.conf \
  unrealircd
```


Host
------

```
/opt/letsencrypt/letsencrypt-auto certonly

cp /etc/letsencrypt/live/example.com/fullchain.pem /opt/docker/unrealircd/ssl/server.cert.pem
cp /etc/letsencrypt/live/example.com/privkey.pem /opt/docker/unrealircd/ssl/server.key.pem
docker exec -d unrealircd chown -R ircd:ircd /home/ircd/unrealircd/conf/ssl
docker exec -d unrealircd bash -c 'kill -USR1 $(/usr/bin/supervisorctl pid irc:unreal)'
```
 
