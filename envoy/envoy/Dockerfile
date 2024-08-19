From envoyproxy/envoy:v1.21-latest

WORKDIR /etc/envoy

COPY ./envoy.yaml ./envoy.yaml

EXPOSE 10000

CMD ["envoy", "-c",  "/etc/envoy/envoy.yaml", "--log-level", "debug"]
