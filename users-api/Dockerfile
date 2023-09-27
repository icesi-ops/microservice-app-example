# Use the official OpenJDK image as base
FROM openjdk:8

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file to the working directory
COPY target/users-api-0.0.1-SNAPSHOT.jar .

# Expose the port the service listens on
ENV SERVER_PORT=8083
EXPOSE $SERVER_PORT

# Command to run the application
CMD ["java", "-jar", "users-api-0.0.1-SNAPSHOT.jar"]
