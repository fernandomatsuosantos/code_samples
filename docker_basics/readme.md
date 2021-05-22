# Docker POC

This POC will have the following objective:

-   Create a Dockerfile to install httpd from an ubuntu image
-   Create 2 images using yml file (docker-compose.yml)

1.  httpd from an ubuntu image (Dockerfile)
2.  MySql

_PS: httpd server will have a php file demonstrating how to access data connecting httpd to MySql_

## Prerequisites

-   [Docker](https://www.docker.com/) installed.

### Clone the Github repository

```bash
git clone git@github.com:fernandomatsuosantos/code_samples.git
```

## Tutorial

-   Generate a container with httpd:

```bash
docker build -t fms/apache:latest .
docker run -d -p 8080:80
```

Access: <http://localhost:8080>

-   Generate a container with httpd and another with MySql using yml:

```bash
docker-compose up --build -d
```

Access: <http://localhost:8080>

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
