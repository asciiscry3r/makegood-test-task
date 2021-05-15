FROM nginx:latest

RUN openssl dhparam -out /etc/nginx/ssl-dhparam.pem 2048

COPY default.conf /etc/nginx/conf.d/default.conf

COPY nginx-ssl-options.conf /etc/nginx/nginx-ssl-options.conf 

COPY nginx.conf /etc/nginx/nginx.conf

