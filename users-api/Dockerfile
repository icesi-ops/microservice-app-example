FROM openjdk:8-jdk


WORKDIR /usr/src/app


COPY . .

RUN ./mvnw clean install

ENV SPRING_ZIPKIN_BASE_URL=http://zipkin:9411 
ENV JWT_SECRET=PRFT
ENV SERVER_PORT=8083


EXPOSE $SERVER_PORT


CMD ["java", "-jar", "target/users-api-0.0.1-SNAPSHOT.jar"]
