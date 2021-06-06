# Docker POC

This POC will create 3 dockers:

-   nginx load-balancer
-   httpd web server
-   nginx web server

The nginx will act as a load balancer routing the traffic between httpd web server and nginx web server

## Prerequisites

-   [Docker](https://www.docker.com/) installed.

## Tutorial

```bash
docker-compose up --build
```

Access: <http://localhost>

_Every time you refresh the page the access will switch between httpd and nginx, so you will see a page with the following content:_

-   It works! (httpd)
-   Welcome to nginx! (nginx)

## Install Docker - Ubuntu

```bash
# Set up the repository - https://docs.docker.com/engine/install/
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Install Compose - https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Useful commands

```bash
#Docker Hub = https://hub.docker.com/

#Show version
docker version

#Run container and command = docker run <image name> <command>
docker run -it ubuntu bash 
#it=allow input/output
#docker run = docker create <image name> + docker start <container id>

#Runs command in a existing container
docker exec -it <container id> bash #or docker exec -it <container id> sh

#Stop container
docker stop <container id> #terminate signal (if does not stop in 10 secconds kill will be automatically called)
docker kill <container id> #kill signal

#List all running containers 
docker ps

#List all created containers (stopped)
docker ps --all

#Stop all containers
docker stop $(docker ps -a -q)

#Remove all images
docker rm $(docker ps -a -q)

#Delete all containers/networks/images/cache
docker system prune

#Get logs from a container
docker logs <container id>

#Create image using Dockerfile
#tag pattern: <docker id>/<project name>:latest
docker build -t fms/apache:latest . #-t=tag

#docker build -t fms/apache:latest -f Dockerfile.dev . #another filename
docker run -d -p 8080:80 <image name>
# OR
sudo docker run -d -p 8080:80 fms/apache
#-d option (short for --detach) causes the container to run in background
#-p option (short for --publish) is needed in order to publish a container port (or a range of ports)
#8080:80 = request port:container port

#Manual image generation - WindowsXLinux
docker commit -c 'CMD ["apache-server"]' CONTAINERID
docker commit -c "CMD 'apache-server'" CONTAINERID #Windows

#Get docker machine IP
docker-machine ip

#build based on yaml file
docker-compose up -d

#build based on yaml file and rebuild the image
docker-compose up --build -d

#stop containers
docker-compose down

#List all running containers 
docker-compose ps
```