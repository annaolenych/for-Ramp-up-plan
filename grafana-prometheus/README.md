### README.md

# Monitoring Setup with Prometheus and Grafana

This setup includes Prometheus for monitoring and Grafana for visualizing the metrics collected. The configuration also includes Node Exporter to collect hardware and OS metrics from the host.

## Prerequisites

- Docker
- Docker Compose

## Files Included

1. `docker-compose.yml`
2. `prometheus.yml`

## `docker-compose.yml`

```yaml
version: '3.3'

networks:
  monitoring:
    driver: bridge

volumes:
  prometheus_data: {}

services:
  node-exporter:
    image: prom/node-exporter:v1.3.1
    container_name: node-exporter
    restart: unless-stopped
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro
    command:
      - '--path.procfs=/host/proc'
      - '--path.rootfs=/rootfs'
      - '--path.sysfs=/host/sys'
      - '--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($$|/)'
    ports:
      - 9100:9100
    networks:
      - monitoring

  prometheus:
    image: prom/prometheus:v2.31.1
    container_name: prometheus
    restart: unless-stopped
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--web.enable-lifecycle'
    ports:
      - 9090:9090
    networks:
      - monitoring

  grafana:
    image: grafana/grafana:7.5.7
    container_name: grafana
    restart: unless-stopped
    ports:
      - 3000:3000
    networks:
      - monitoring
```

## `prometheus.yml`

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    scrape_interval: 5s
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node"
    static_configs:
      - targets: ["node-exporter:9100"]
```

## How to Run

1. **Clone the repository or download the files:**

   ```sh
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Start the Docker containers:**

   ```sh
   docker-compose up -d
   ```
<img width="1080" alt="Screenshot 2024-07-05 at 15 03 44" src="https://github.com/annaolenych/for-Ramp-up-plan/assets/95705808/7a130f4a-528f-4b45-ab36-a1bb6d4db22d">

3. **Verify the services:**

   - Prometheus should be accessible at [http://localhost:9090](http://localhost:9090).
<img width="1080" alt="Screenshot 2024-07-05 at 15 03 44" src="https://github.com/annaolenych/for-Ramp-up-plan/assets/95705808/1e1a105a-0964-426d-8dcd-08ed57aa1f3e">


   - Grafana should be accessible at [http://localhost:3000](http://localhost:3000).
   <img width="1308" alt="Screenshot 2024-07-05 at 15 03 36" src="https://github.com/annaolenych/for-Ramp-up-plan/assets/95705808/407da546-3a1f-4a20-b327-04cc5f9587a0">


## Connecting Grafana to Prometheus

1. **Open Grafana in your browser:**

   Go to [http://localhost:3000](http://localhost:3000).

2. **Log in to Grafana:**

   - Default username: `admin`
   - Default password: `admin`
   - You will be prompted to change the password upon first login.

3. **Add Prometheus as a data source:**

   - Click on the gear icon (⚙️) to open the Configuration menu.
   - Select "Data Sources".
   - Click "Add data source".
   - Select "Prometheus" from the list.
   - Set the URL to `http://prometheus:9090`.
     <img width="1314" alt="Screenshot 2024-07-08 at 15 41 18" src="https://github.com/annaolenych/for-Ramp-up-plan/assets/95705808/66b5cef8-5c11-45f9-ad77-d880a14ed190">
   - Click "Save & Test" to verify the connection.
   <img width="1109" alt="Screenshot 2024-07-08 at 15 41 10" src="https://github.com/annaolenych/for-Ramp-up-plan/assets/95705808/8f1f938a-f830-4553-ac06-292e69aed37b">


## Creating Dashboards

1. **Create a new dashboard:**

   - Click the "+" icon on the left sidebar and select "Dashboard".
   - Click "Add new panel".

2. **Configure the panel:**

   - In the Query section, select "Prometheus" as the data source.
   - Enter a query (e.g., `up` to check if the Prometheus instance is up).
   - Customize the visualization as needed.

3. **Save the dashboard:**

   - Click "Save dashboard" at the top right, provide a name, and save it.
