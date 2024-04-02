FROM golang:1.19
WORKDIR /auth-api
COPY . .
ENV GO111MODULE=on
RUN go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
RUN go mod tidy
RUN go build
ENV JWT_SECRET=PRFT 
ENV AUTH_API_PORT=8000
EXPOSE ${AUTH_API_PORT}
ENV USERS_API_ADDRESS=http://users-api:8083
CMD [ "./auth-api" ]
