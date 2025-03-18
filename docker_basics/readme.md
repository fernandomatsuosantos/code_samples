## Install Docker - Ubuntu

```bash
# Set up the repository - https://docs.docker.com/engine/install/
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine & Compose
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose
sudo docker run hello-world #verify instalation
sudo usermod -aG docker $USER #optional
```

## Useful commands

```bash
#Docker Hub = https://hub.docker.com/

#Show version
docker version

#Run container and command = docker run <image name> <command>
docker run -it catthehacker/ubuntu:act-latest bash 
#it=allow input/output
#docker run = docker create <image name> + docker start <container id>

#Runs command in a existing container
docker exec -it <container id> bash #or docker exec -it <container id> sh

#Stop container
docker stop <container id> #terminate signal (if does not stop in 10 secconds kill will be automatically called)
docker kill <container id> #kill signal

#List all running containers 
docker ps

#List all created containers
docker ps --all

#Get logs from a container
docker logs --since=1h <container id>

#docker build -t fms/apache:latest -f Dockerfile.dev . #another filename
docker run -d -p 8080:80 <image name>
# OR
docker run -d -p 80:80 httpd
#-d option (short for --detach) causes the container to run in background
#-p option (short for --publish) is needed in order to publish a container port (or a range of ports)
#8080:80 = <request port>:<container port>

#Manual image generation - WindowsXLinux
docker commit -c 'CMD ["apache-server"]' CONTAINERID
docker commit -c "CMD 'apache-server'" CONTAINERID #Windows

#Get docker machine IP
docker-machine ip

#build based on yaml file, rebuild the image and remove orphans
docker-compose up --build -d --remove-orphans

#stop containers
docker-compose down

#List all running containers 
docker-compose ps

#Stop all containers
docker stop $(docker ps -a -q)

#Remove all images
docker rm $(docker ps -a -q)

#Delete all containers/networks/images/cache
docker system prune
```