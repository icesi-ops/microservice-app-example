FROM golang:1.21

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
#RUN go mod download && go mod verify

COPY . .
ENV GO111MODULE=on
RUN go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
RUN go mod download
RUN go mod verify
RUN go mod tidy
RUN go build -v -o /usr/local/bin/app ./...

CMD ["app"]