FROM golang:1.9-alpine

WORKDIR /go/src/app

EXPOSE 8000

ENV ZIPKIN_URL=http://zipkin:9411/api/v2/spans \
    JWT_SECRET=PRFT \
    USERS_API_ADDRESS=http://users-api:8083 \
    AUTH_API_PORT=8000

RUN apk --no-cache add curl git && \
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

COPY . .

RUN dep ensure

RUN go build -o auth-api

CMD /go/src/app/auth-api

