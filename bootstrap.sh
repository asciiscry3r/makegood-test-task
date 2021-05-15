#!/usr/bin/env bash

mkdir -p certbot/{conf,www}

git submodule update --init --recursive

if [ ! -f "/usr/local/bin/docker-compose" ]; then
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
fi

if [ -d NodeJS ]; then
	cd NodeJS && sudo docker build -t makegood-nodejs . && cd ..
else
	echo "Sorry but we lost our NodeJS files"
fi

if [ -d nginx ]; then
	cd nginx-docker && sudo docker build -t makeggod-nginx . && cd ..
else
	echo "Sorry but we lost our Nginx files"
fi

sudo docker-compose up -d

