FROM golang:1.18.2
COPY . /app
WORKDIR /app

ENV GO111MODULE=on
ENV JWT_SECRET=PRFT
ENV AUTH_API_PORT=8000
ENV USERS_API_ADDRESS=http://127.0.0.1:8083

RUN go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
RUN go mod tidy
RUN go build

CMD ["./auth-api"]

