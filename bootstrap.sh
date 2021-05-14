#!/usr/bin/env sh

if [ -d NodeJS ]; then
	cd NodeJS && docker build -t makegood-nodejs . && cd ..
else
	echo "Sorry but we lost our Dokerfile"
fi

if [ -d NodeJS/makegood ]; then
	cd NodeJS/makegood && git pull && cd ../..
else
	git pull https://github.com/nginxinc/docker-nginx.git NodeJS/makegood
fi



docker swarm init

docker stack deploy -c docker-compose.yaml makegood

