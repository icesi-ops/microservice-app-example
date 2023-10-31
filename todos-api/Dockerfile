FROM node:8-alpine

EXPOSE 8082

WORKDIR /usr/src/app
ENV REDIS_HOST=redis_queue \
    ZIPKIN_URL=http://zipkin:9411/api/v2/spans \
    REDIS_PORT=6379 \
    TODO_API_PORT=8082 \
    JWT_SECRET=PRFT \
    REDIS_CHANNEL=log_channel
    

COPY package.json ./
RUN npm install

COPY . .

CMD ["sh", "-c", "npm start" ]