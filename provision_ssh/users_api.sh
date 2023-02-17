#!/bin/bash

# Install Java
sudo apt update
sudo apt install -y openjdk-8-jdk
sudo apt install maven

# Clone the repository
git clone https://github.com/ChristianFlor/microservice-app-example.git

# Change to the users-api directory
cd microservice-app-example/users-api

# Build the Spring Boot application
./mvnw clean install

# Set the environment variables
export JWT_SECRET=PRFT 
export SERVER_PORT=8083

# Run the application
java -jar target/users-api-0.0.1-SNAPSHOT.jar
