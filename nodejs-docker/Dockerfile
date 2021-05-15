FROM alpine:3.13.5

RUN apk add --update nodejs npm && \
    npm install pm2 -g

COPY makegood /makegood

WORKDIR /makegood

RUN npm i

EXPOSE 3000

CMD ["pm2-runtime", "index.js"]

