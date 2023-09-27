# Use the official Golang image as the base image
FROM golang:1.18.2

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the Go application
RUN export GO111MODULE=on && \
    go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api && \
    go mod tidy && \
    go build

# Set environment variables
ENV AUTH_API_PORT=8000
ENV USERS_API_ADDRESS=http://127.0.0.1:8083
ENV JWT_SECRET=PRFT

# Expose the port the application runs on
EXPOSE $AUTH_API_PORT

# Command to run the application
CMD ["./auth-api"]
