FROM node:8.17-alpine
WORKDIR /app
COPY . /app

ENV TODO_API_PORT=8082
ENV JWT_SECRET=PRFT
ENV REDIS_HOST=redis-logger
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel

RUN npm install
EXPOSE 8082
CMD npm start

#ENTRYPOINT ["node", "index.js"]
#COPY package.json /app