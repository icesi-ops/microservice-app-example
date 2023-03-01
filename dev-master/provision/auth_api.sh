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

if [["$(systemctl is-active docker)" != "active"]]
then
    sudo systemctl start docker
fi

# Clone the repository if not already cloned
if [ ! -d "microservice-app-example" ]
then
    git clone https://github.com/ChristianFlor/microservice-app-example.git
fi

# Change to the auth_api directory
cd microservice-app-example/auth-api

# Build the Docker image if not already built
if ! docker images | grep -q "auth-api"
then
    docker build -t auth-api .
fi

# Run the application
docker run --rm -d -p 3000:3000 -e ZIPKIN_URL=http://zipkin:9411/api/v2/spans -e JWT_SECRET=PRFT -e AUTH_API_PORT=3000 -e USERS_API_ADDRESS=http://192.168.33.10:8083 auth-api
