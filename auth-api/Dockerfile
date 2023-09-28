FROM golang:1.9-alpine
WORKDIR /go/src/app
EXPOSE 8000
# Definir las variables de entorno necesarias para la aplicación
ENV JWT_SECRET=PRFT \
    ZIPKIN_URL=http://zipkin:9411/api/v2/spans \
    AUTH_API_PORT=8000 \
    USERS_API_ADDRESS=http://users-api:8083
   
RUN apk --no-cache add curl git && \
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

COPY . .
RUN dep ensure

RUN go build -o auth-api

CMD /go/src/app/auth-api