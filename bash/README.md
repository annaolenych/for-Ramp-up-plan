# Nginx Monitor Script

This script is a simple curl-based monitor to check the status of an Nginx proxy running in an Ubuntu container. It logs the status of the Nginx server to a log file and can be scheduled to run at regular intervals using cron.

## Prerequisites

- Docker
- curl
- bash

## Getting Started

### 1. Run Nginx in an Ubuntu Container

First, ensure you have Docker installed and running. Then, create and start an Nginx container:

```bash
docker run -d --name nginx-container -p 80:80 nginx
