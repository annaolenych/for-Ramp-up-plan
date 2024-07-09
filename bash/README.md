
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
```

### 2. Create the Monitor Script

Create a script named `nginx_monitor.sh` .

### 3. Make the Script Executable

Change the permissions of the script to make it executable:

```bash
chmod +x ~/nginx_monitor.sh
```

### 4. Run the Script

You can manually run the script to check if it works:

```bash
./nginx_monitor.sh
```

Check the log file to see the output:

```bash
cat ~/nginx_monitor.log
```

<img width="448" alt="Screenshot 2024-07-09 at 15 39 14" src="https://github.com/annaolenych/for-Ramp-up-plan/assets/95705808/3452970c-c9e4-4d7b-a6d3-c5db5fa1b106">

### 5. Automate the Script with Cron

To automate the script to run every 5 minutes, edit the cron jobs:

```bash
crontab -e
```

Add the following line to schedule the script:

```bash
*/5 * * * * /path/to/nginx_monitor.sh
```

Replace `/path/to/nginx_monitor.sh` with the actual path to your script.

### 6. Verify the Cron Job

After a few minutes, check the log file again to ensure that the script is running as expected:

```bash
cat ~/nginx_monitor.log
```
