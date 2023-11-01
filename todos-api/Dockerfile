FROM node:8-alpine
WORKDIR /app
COPY . /app

EXPOSE 8082

ENV REDIS_HOST=redis_queue \ 
    REDIS_PORT=6379 \
    TODO_API_PORT=8082 \
    REDIS_CHANNEL=log_channel \
    JWT_SECRET=PRFT\
     ZIPKIN_URL=http://zipkin:9411/api/v2/spans


RUN npm install

CMD npm start
