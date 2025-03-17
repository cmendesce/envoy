FROM envoyproxy/envoy:v1.22.0

# Copie o arquivo de configuração e o entrypoint script
COPY envoy.yaml /etc/envoy/envoy.yaml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Dê permissão de execução ao entrypoint script
RUN chmod +x /usr/local/bin/entrypoint.sh

# Defina o entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]