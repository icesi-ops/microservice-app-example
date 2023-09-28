FROM openjdk:8-alpine

EXPOSE 8083

ENV JWT_SECRET=PRFT \
    SPRING_ZIPKIN_BASE_URL=http://zipkin:9411 \
    SERVER_PORT=8083
WORKDIR /usr/src/app
COPY . .
RUN ./mvnw clean install

CMD ["java", "-jar", "./target/users-api-0.0.1-SNAPSHOT.jar"]