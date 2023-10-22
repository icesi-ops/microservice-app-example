# Use the official OpenJDK 11 image as a parent image
FROM openjdk:8-jdk

# Create a directory to store the application JAR file
WORKDIR /app

# Copy the JAR file into the container
COPY . .

RUN ./mvnw clean install

# Set environment variables
ENV JWT_SECRET=PRFT
ENV SERVER_PORT=8083

# Expose the port on which the application will run
EXPOSE $SERVER_PORT

# Command to run the application
CMD ["java", "-jar", "target/users-api-0.0.1-SNAPSHOT.jar"]

