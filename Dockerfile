FROM jenkins/inbound-agent:latest

USER root

# Instalar Docker dentro del contenedor
RUN apt-get update && \
    apt-get install -y docker.io && \
    rm -rf /var/lib/apt/lists/*

USER jenkins
