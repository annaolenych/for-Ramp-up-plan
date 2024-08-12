# OpenTelemetry Collector with Datadog Integration

This project sets up an OpenTelemetry Collector with Datadog integration using Docker Compose. The collector receives, processes, and exports metrics, traces, and logs to Datadog.

## Prerequisites

- Docker and Docker Compose installed on your system.
- A Datadog account with an API key.

## Setup

1. **Clone the repository**:

    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2. **Configure the OpenTelemetry Collector**:

    The configuration file `otel-config.yaml` specifies the settings for the OpenTelemetry Collector. It includes receivers for OTLP (OpenTelemetry Protocol) and host metrics, processors for batching, and exporters to Datadog.

    Update the `datadog` exporter section in `otel-config.yaml` with your Datadog site and API key:

    ```yaml
    exporters:
      datadog:
        api:
          site: <your-datadog-site>
          key: <your-datadog-api-key>
    ```

    - Replace `<your-datadog-site>` with your Datadog site (e.g., `datadoghq.com` or `datadoghq.eu`).
    - Replace `<your-datadog-api-key>` with your Datadog API key.

3. **Start the OpenTelemetry Collector**:

    Run the following command to start the OpenTelemetry Collector:

    ```bash
    docker-compose up -d
    ```

    This will start the `otel-collector` service, which listens on various ports to receive data and send it to Datadog.

## Configuration Details

- **Ports**:
  - `1888`: pprof extension for profiling.
  - `13133`: health_check extension.
  - `4317`: OTLP gRPC receiver.
  - `55670`: zpages extension.
  - `4318`: OTLP HTTP receiver.

- **Receivers**:
  - `otlp`: Receives telemetry data over HTTP and gRPC.
  - `hostmetrics`: Collects metrics about the host system (CPU, memory, disk, etc.).

- **Processors**:
  - `batch`: Batches data before sending it to Datadog.

- **Exporters**:
  - `datadog`: Exports metrics, traces, and logs to Datadog.

## Monitoring

Once the collector is running, you can monitor the collected metrics, traces, and logs in your Datadog dashboard.
<img width="898" alt="Screenshot 2024-07-30 at 12 59 52" src="https://github.com/user-attachments/assets/787e389b-b4ac-4d23-b951-fe740a7af2a6">
<img width="1295" alt="Screenshot 2024-07-30 at 12 59 37" src="https://github.com/user-attachments/assets/1dfca19f-e1e7-4e54-90a6-e9c6711bbef7">


## Troubleshooting

- If the collector fails to start, check the Docker Compose logs:

    ```bash
    docker-compose logs
    ```
<img width="1153" alt="Screenshot 2024-07-24 at 14 45 10" src="https://github.com/user-attachments/assets/a0e92697-1a9f-4648-990b-df35f5d7cf33">

- Ensure your Datadog API key is correctly configured in `otel-config.yaml`.

## Stopping the Collector

To stop the OpenTelemetry Collector, run:

```bash
docker-compose down
