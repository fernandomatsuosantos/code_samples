# Docker POC

This POC will load ubuntu and install apache.

## Prerequisites

-   [Docker](https://www.docker.com/) installed.

## Tutorial

```bash
docker build -t fms/httpd:latest .
docker run -d -p 80:80 fms/httpd
```

Access: <http://localhost>
