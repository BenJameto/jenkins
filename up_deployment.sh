#!/bin/bash

# Función para escalar un servicio en Kubernetes
scale_service() {
    local service_name=$1
    local replicas=$2

    # Escalar el servicio usando kubectl
    kubectl scale deployment "$service_name" --replicas="$replicas"
    
    # Verificar si el comando fue exitoso
    if [ $? -eq 0 ]; then
        echo "Servicio $service_name escalado a $replicas réplicas."
    else
        echo "Error escalando el servicio $service_name."
    fi
}

# Definir el nombre del servicio y el número de réplicas
service_name="nombre-del-servicio"  # Cambia por el nombre de tu servicio
replicas=3

# Llamar a la función para escalar el servicio
scale_service "$service_name" "$replicas"
