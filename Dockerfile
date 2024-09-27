FROM jenkins/inbound-agent:latest

USER root

# Instalar Docker utilizando un script oficial
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://get.docker.com | sh

# Habilitar uso de Docker sin root (opcional)
RUN usermod -aG docker jenkins

USER jenkins
