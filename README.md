# Envoy Fault Injection Proxy

This repository provides a lightweight Envoy configuration that can inject HTTP 503 fault responses with a configurable percentage.

## How It Works

This setup is designed to run Envoy as a **sidecar proxy** in a Kubernetes deployment.

The backend application is always accessed at `127.0.0.1` (localhost) and can configure the backend's port and fault injection percentage using environment variables:

  1. **`FAULT_PERCENTAGE`**: Controls the percentage of HTTP 503 errors to inject. Defaults to `0` (no faults).
  2. **`BACKEND_PORT`**: Specifies the port where the backend application listens. Defaults to `80`.

This makes it easy to dynamically configure Envoy without modifying the application or its configuration files.

## Sample

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-service
  labels:
    app: my-service
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-service
  template:
    metadata:
      labels:
        app: my-service
    spec:
      serviceAccountName: my-service
      containers:
      - name: server
        image: my-service-image
        ports:
        - containerPort: 50051
      - name: envoy
        image: ghcr.io/cmendesce/envoy:latest
        ports:
        - containerPort: 9901 # admin port
        - containerPort: 10000 # service proxy port
        env:
          - name: FAULT_PERCENTAGE
            value: "25" # fault to be injected
          - name: BACKEND_PORT
            value: "50051" # service port
---
apiVersion: v1
kind: Service
metadata:
  name: my-service
  labels:
    app: my-service
spec:
  type: ClusterIP
  selector:
    app: my-service
  ports:
  - name: grpc
    port: 50051
    targetPort: 10000 # service redirects the request to envoy
```
