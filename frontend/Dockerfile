FROM node:8-alpine


EXPOSE 8080

ENV PORT=8080
ENV AUTH_API_ADDRESS=http://auth-api:8000
ENV TODOS_API_ADDRESS=http://todos-api:8082
ENV ZIPKIN_URL=http://zipkin:9411/api/v2/spans 
WORKDIR /usr/src/app

COPY package.json ./
RUN npm install

COPY . .

CMD ["sh", "-c", "npm start" ]