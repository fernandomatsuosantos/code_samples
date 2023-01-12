# Scout Suite

## How to scan Azure using Scout Suite and docker

-   Clone the ScoutSuite [GitHub Repo](https://github.com/nccgroup/ScoutSuite)
-   Change to the ScoutSuite/docker directory
-   Run docker-compose up --build to create the container
-   Run ScoutSuite in the container using docker run -it scoutsuite


```bash

# clone repo
git clone https://github.com/nccgroup/ScoutSuite.git

# create container
cd ScoutSuite/docker
sudo docker-compose up --build

# access container
sudo docker exec -it scoutsuite

# do the security check
az login
scout azure --all-subscriptions --cli --no-browser --report-dir /root/scout-report

# copy report to local machine
sudo docker cp scoutsuite:/root/scout-report ./
```

-   [Scout Suite](https://github.com/nccgroup/ScoutSuite)
