# Scout Suite

## How to scan Azure using Scout Suite and docker

```bash
# scoutsuite docker
docker run -it rossja/stratus

# get container-id
docker ps -f ancestor=rossja/stratus --format "{{.ID}}"

# access container
docker exec -it <container-id> bash

# do the security check
az login
scout azure --cli --no-browser --report-dir /root/scout-report

# copy report to local machine
docker cp <container-id>:/root/scout-report ./
```

-   [Scout Suite](https://hub.docker.com/r/rossja/ncc-scoutsuite/)
-   [Scout Suite Docker](https://github.com/rossja/stratus)
