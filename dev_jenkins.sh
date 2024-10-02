#!/bin/bash

# Nombre del archivo de configuración de Jenkins
CONFIG_FILE="jenkins-dind-deployment.yaml"

# Función para verificar si un comando fue exitoso
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Iniciar Minikube si no está corriendo
if ! minikube status | grep -q "Running"; then
    echo "Iniciando Minikube..."
    minikube start
    check_command "No se pudo iniciar Minikube"
fi

# Crear el namespace jenkins
echo "Creando namespace jenkins..."
kubectl create namespace jenkins
check_command "No se pudo crear el namespace jenkins"

# Aplicar la configuración de Jenkins
echo "Aplicando configuración de Jenkins..."
kubectl apply -f $CONFIG_FILE
check_command "No se pudo aplicar la configuración de Jenkins"

# Esperar a que el pod de Jenkins esté listo
echo "Esperando a que el pod de Jenkins esté listo..."
kubectl wait --for=condition=ready pod -l app=jenkins -n jenkins --timeout=300s
check_command "El pod de Jenkins no está listo después de 5 minutos"

# Obtener la URL de Jenkins
echo "Obteniendo URL de Jenkins..."
JENKINS_URL=$(minikube service jenkins -n jenkins --url)
check_command "No se pudo obtener la URL de Jenkins"

# Obtener la contraseña inicial de administrador
echo "Obteniendo contraseña inicial de administrador..."
ADMIN_PASSWORD=$(kubectl exec -it $(kubectl get pods -n jenkins -l app=jenkins -o jsonpath='{.items[0].metadata.name}') -n jenkins -- cat /var/jenkins_home/secrets/initialAdminPassword)
check_command "No se pudo obtener la contraseña inicial de administrador"

echo "Jenkins ha sido desplegado exitosamente!"
echo "URL de Jenkins: $JENKINS_URL"
echo "Contraseña inicial de administrador: $ADMIN_PASSWORD"
echo "Usa estas credenciales para configurar Jenkins en tu navegador."