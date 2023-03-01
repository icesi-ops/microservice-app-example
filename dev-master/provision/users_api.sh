#!/bin/bash

# Install Docker if not already installed
if ! command -v docker &> /dev/null
then
    sudo apt-get -y update
    sudo apt-get -y upgrade

    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER

    sudo reboot

    sleep 30
fi

# Clone the repository if not already cloned
if [ ! -d "microservice-app-example" ]
then
    git clone https://github.com/ChristianFlor/microservice-app-example.git
fi

# Change to the users-api directory
cd microservice-app-example/users-api

if [["$(systemctl is-active docker)" != "active"]]
then
    sudo systemctl start docker
fi

# Build the Docker image if not already built
if ! docker images | grep -q "users-api"
then
    docker build -t users-api .
fi

# Run the application
docker run --rm -d -p 8083:8083 -e SPRING_ZIPKIN_BASE_URL=http://zipkin:9411 -e JWT_SECRET=PRFT -e SERVER_PORT=8083 users-api

