FROM golang:alpine AS build
WORKDIR /usr/src/app



ENV GO111MODULE=on
RUN go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
RUN go clean -modcache
COPY . .
RUN go mod tidy

EXPOSE 8081

RUN go build -v -o /usr/local/bin/app .

CMD [ "app" ]