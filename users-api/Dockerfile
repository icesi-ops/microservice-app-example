# First stage: build the application
FROM maven:3.8.6-openjdk-8 AS build
WORKDIR /app
COPY . /app
RUN mvn clean install

# Second stage: create a slim image
FROM openjdk:8-jre-slim
EXPOSE 8083
COPY --from=build /app/target/users-api-0.0.1-SNAPSHOT.jar users-api-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/users-api-0.0.1-SNAPSHOT.jar"]
