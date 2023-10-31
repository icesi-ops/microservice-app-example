FROM node:8.17-alpine
WORKDIR /app
COPY . /app

ENV TODOS_API_ADDRESS=http://todos-api:8082
ENV PORT=8080
ENV AUTH_API_ADDRESS=http://auth-api:8000
RUN npm install
RUN npm run build
EXPOSE 8080
CMD npm start

#ENTRYPOINT ["node", "index.js"]
#COPY package.json /app