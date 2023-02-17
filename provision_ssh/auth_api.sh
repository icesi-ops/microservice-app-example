#!/bin/bash

# Install Go
sudo apt-get -y update
sudo apt-get -y upgrade

wget https://dl.google.com/go/go1.18.2.linux-amd64.tar.gz
sudo tar -xvf go1.18.2.linux-amd64.tar.gz
sudo mv go /usr/local

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

source ~/.profile

# Download the Go application
# Clone the repository
export GO111MODULE=on
go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api
go mod init github.com/ChristianFlor/microservice-app-example/tree/master/auth-api
go mod tidy
go build


# Set the environment variables
export JWT_SECRET=PRFT 
#export GO111MODULE=on
export AUTH_API_PORT=8000 
export USERS_API_ADDRESS=http://127.0.0.1:8083



# Run the application
./auth-api
