#!/usr/bin/env bash

git submodule update --init --recursive

if [ -d NodeJS ]; then
	cd NodeJS && docker build -t makegood-nodejs . && cd ..
else
	echo "Sorry but we lost our NodeJS files"
fi

if [ -d nginx ]; then
	cd nginx && docker build -t makeggod-nginx . && cd ..
else
	echo "Sorry but we lost our Nginx files"
fi

