FROM envoyproxy/envoy:v1.22.0
COPY envoy.yaml /etc/envoy/envoy.yaml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]