# OpenTelemetry Collector with Datadog Exporter

This project demonstrates how to set up the OpenTelemetry Collector to send metrics to Datadog. The setup includes using Docker and Docker Compose to manage the services.

## Prerequisites

- Docker
- Docker Compose

## Getting Started

1. **Clone the repository:**

2. **Create the OpenTelemetry Collector configuration file:**

   Create a file named `otel-config.yaml` in the root of your project 

   Replace `YOUR_DATADOG_API_KEY` with your actual Datadog API key.

3. **Create the Docker Compose file:**

   Create a file named `docker-compose.yml` in the root of your project.

4. **Start the OpenTelemetry Collector:**

   ```bash
   docker-compose up -d
   ```

   This command will start the OpenTelemetry Collector in detached mode.

5. **Verify the Collector is Running:**

   Check the logs to ensure the collector is running properly:

   ```bash
   docker-compose logs otel-collector
   ```
<img width="1153" alt="Screenshot 2024-07-24 at 14 45 10" src="https://github.com/user-attachments/assets/24319196-4455-448d-a58f-69068d2ba946">


<img width="263" alt="Screenshot 2024-07-24 at 15 20 30" src="https://github.com/user-attachments/assets/a216c3f3-4dea-4c77-95ca-1231c8cb4daf">
