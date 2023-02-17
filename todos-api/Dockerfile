FROM node:16-alpine

WORKDIR /usr/src/app
EXPOSE 8082
ENV TODO_API_PORT=8082
COPY . .
RUN npm install
CMD ["npm","start"]