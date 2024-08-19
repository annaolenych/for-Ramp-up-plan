
# Envoy Proxy Reverse Proxy 

This project demonstrates how to set up Envoy Proxy as a reverse proxy to route traffic to a simple Node.js API. Envoy Proxy will forward requests to the Node.js service and handle responses.

## Project Overview

- **Envoy Proxy**: Acts as a reverse proxy that routes incoming requests to the Node.js service.
- **Node.js API**: A basic Node.js server that serves as the backend service.

## Prerequisites

- [Node.js](https://nodejs.org/) (for running the Node.js API)
- [Envoy Proxy](https://www.envoyproxy.io/docs/envoy/latest/start/install) (for routing requests)

## Project Structure

- `envoy.yaml`: Envoy Proxy configuration file.
- `app.js`: Node.js application code.
- `package.json`: Node.js dependencies.

## Setup and Installation

### 1. Node.js API

1. **Install Dependencies**

   Navigate to the project directory and install Node.js dependencies:

   ```bash
   npm install

2. **Start Node.js Server**

   Run the Node.js application:

   ```bash
   node app.js
   ```

   The server will listen on port `8080`.

### 2. Envoy Proxy

1. **Download and Install Envoy**

   Follow the [Envoy Installation Guide](https://www.envoyproxy.io/docs/envoy/latest/start/install) to install Envoy.

2. **Configure Envoy**

   Place the `envoy.yaml` configuration file in the Envoy installation directory or specify its path when starting Envoy.

3. **Run Envoy**

   Start Envoy with the configuration file:

   ```bash
   envoy -c envoy.yaml
   ```

   Envoy will listen on port `10000`.

## Envoy Configuration (`envoy.yaml`)

```yaml
static_resources:
  listeners:
  - name: listener_0
    address:
      socket_address: { address: 0.0.0.0, port_value: 10000 }
    filter_chains:
    - filters:
      - name: envoy.filters.network.http_connection_manager
        config:
          codec_type: AUTO
          stat_prefix: ingress_http
          route_config:
            name: local_route
            virtual_hosts:
            - name: backend_service
              domains:
              - '*'
              routes:
              - match: { prefix: "/" }
                route:
                  cluster: node_service
          http_filters:
          - name: envoy.filters.http.router
  clusters:
  - name: node_service
    connect_timeout: 0.25s
    type: LOGICAL_DNS
    lb_policy: ROUND_ROBIN
    hosts:
    - socket_address: { address: 127.0.0.1, port_value: 8080 }
```

## API Endpoints

- **GET `/`**: Returns "Hello, World!" from the Node.js API.
- **GET `/api/greet`**: Returns a greeting message from the Node.js API.
- **POST `/api/echo`**: Echoes back the JSON data sent in the request.

## Testing the API

### GET `/`

```bash
curl http://localhost:10000/
```

**Response**:
```
Hello, World!
```

### GET `/api/greet`

```bash
curl http://localhost:10000/api/greet
```

**Response**:
```json
{
  "message": "Hello from the API!"
}
```

### POST `/api/echo`

```bash
curl -X POST http://localhost:10000/api/echo -H "Content-Type: application/json" -d '{"foo":"bar"}'
```

**Response**:
```json
{
  "foo": "bar"
}
```

## Resources

- [Envoy Proxy Documentation](https://www.envoyproxy.io/docs/envoy/latest/)
- [Node.js Official Site](https://nodejs.org/)
- [Express Documentation](https://expressjs.com/)

