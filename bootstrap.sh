#!/usr/bin/env sh

if [ -d NodeJS ]; then
	cd NodeJS
        [ -d makegood  ] && cd makegood && git pull && cd .. || git clone https://github.com/flour/makegood
	docker build -t makegood-nodejs . && cd ..
else
	echo "Sorry but we lost our NodeJS files"
fi

if [ -d nginx ]; then
	cd nginx && docker build -t makeggod-nginx . && cd ..
else
	echo "Sorry but we lost our Nginx files"
fi



