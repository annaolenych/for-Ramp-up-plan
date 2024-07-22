Certainly! Here’s a detailed `README.md` in English for your custom Datadog check Docker setup:

# Nginx Status Check Docker

This project provides a custom Datadog check that monitors the status of an Nginx page. The Docker container is set up to run this check in a Datadog environment.

## Overview

1. **Dockerfile**:
   - Uses Python 3.12 (slim version).
   - Installs the `requests` and `datadog` libraries.
   - Copies the `nginx_status_check.py` script into the container.
   - Runs the container in an infinite sleep mode.

2. **nginx_status_check.py**:
   - This is a custom Datadog check that queries the status page at a specified URL and reports the HTTP status code as a metric to Datadog.

3. **Configuration**:
   - Includes settings for the check in YAML format.

## Dockerfile

The Dockerfile sets up the environment for the Datadog custom check.

```Dockerfile
FROM python:3.12-slim

RUN pip install requests datadog

COPY nginx_status_check.py /checks.d/nginx_status_check.py

CMD ["sleep", "infinity"]
```

### Instructions:

1. **Base Image**: `python:3.12-slim`
   - A minimal Python 3.12 environment.

2. **Install Dependencies**:
   - `requests`: For making HTTP requests.
   - `datadog`: Datadog's Python library for custom checks.

3. **Copy Check Script**:
   - `nginx_status_check.py` is copied to `/checks.d` where Datadog looks for custom checks.

4. **Run Command**:
   - The container is set to sleep indefinitely. This is because the custom check will be executed by the Datadog Agent, and the container needs to remain running.

## nginx_status_check.py

This script defines a custom Datadog check for monitoring Nginx status.

```python
import requests
from datadog_checks.base import AgentCheck

class NginxStatusCheck(AgentCheck):
    def check(self, instance):
        url = instance.get('url', 'http://localhost')
        try:
            response = requests.get(url)
            
            status_code = response.status_code
            self.gauge('nginx.status_custom_code', status_code, tags=['url:{}'.format(url)])
        except requests.RequestException as e:
            self.log.error(f"Error checking Nginx status: {e}")
            self.gauge('nginx.status_custom_code', 0, tags=['url:{}'.format(url)])
```

### Explanation:

- **Imports**:
  - `requests`: For sending HTTP requests.
  - `AgentCheck`: Base class for Datadog custom checks.

- **NginxStatusCheck Class**:
  - `check(self, instance)`: Main function that performs the check.
    - **URL**: Retrieves the URL from the instance configuration (default is `http://localhost`).
    - **Request**: Sends an HTTP GET request to the URL.
    - **Metric Reporting**:
      - `self.gauge('nginx.status_custom_code', status_code, tags=['url:{}'.format(url)])`: Reports the HTTP status code to Datadog.
    - **Error Handling**:
      - If a request fails, it logs the error and reports a status code of 0.

## Configuration

The configuration file for the custom check should be in YAML format. Here is an example configuration:

```yaml
instances:
  - name: Nginx Status Check
    url: http://nginx_container
```

### Explanation:

- **`instances`**: List of configurations for the check.
  - **`name`**: Descriptive name for the check.
  - **`url`**: The URL of the Nginx status page to monitor.

## How to Run

1. **Build Docker Image**:

    ```sh
    docker build -t nginx-status-check .
    ```

2. **Run the Docker Container**:

    ```sh
    docker run -d --name dddd-agent --network my_network \
    -e DD_API_KEY=464f1c906f6db5ab5bbc75b20e79a2a5 \
    -e DD_SITE="datadoghq.eu" \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -v /proc/:/host/proc/:ro \
    -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
    -v /var/lib/docker/containers:/var/lib/docker/containers:ro \
    -v $(pwd)/nginx_status_check.py:/etc/datadog-agent/checks.d/nginx_status_check.py \
    -v $(pwd)/nginx_status_check.yaml:/etc/datadog-agent/conf.d/nginx_status_check.d/my_custom_check.yaml \
    gcr.io/datadoghq/agent:7
    ```
<img width="458" alt="Screenshot 2024-07-22 at 16 32 55" src="https://github.com/user-attachments/assets/7cd8b3a2-8bcd-4bd0-8f13-a53da7bf47b6">

3. **Verify**:
   - Ensure that the custom check is running properly and reporting metrics to Datadog.

<img width="886" alt="Screenshot 2024-07-22 at 16 34 24" src="https://github.com/user-attachments/assets/a6a6bd7b-bc2d-4bb1-acd0-091eb4a6b84d">
