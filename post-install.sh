#!/bin/bash

cd unrealircd-$UNREAL_VERSION
mv /home/ircd/unrealircd/conf /home/ircd/unrealircd/conf-dist
cp doc/conf/ssl/curl-ca-bundle.crt /home/ircd/unrealircd/conf-dist/ssl/
