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