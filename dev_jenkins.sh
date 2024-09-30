#!/bin/bash

# Nombre del namespace para Jenkins
NAMESPACE="jenkins"

# Verifica si Helm está instalado
if ! command -v helm &> /dev/null
then
    echo "Helm no está instalado. Por favor instala Helm e intenta nuevamente."
    exit 1
fi

# Crear namespace para Jenkins si no existe
echo "Creando el namespace $NAMESPACE si no existe..."
kubectl create namespace $NAMESPACE

# Agregar el repositorio de charts de Jenkins
echo "Agregando el repositorio de charts de Jenkins a Helm..."
helm repo add jenkins https://charts.jenkins.io
helm repo update

# Instalar Jenkins usando Helm
echo "Instalando Jenkins en el namespace $NAMESPACE..."
helm install jenkins jenkins/jenkins --namespace $NAMESPACE \
  --set controller.serviceType=NodePort \
  --set controller.nodePort=32000 \
  --set controller.adminUser=admin \
  --set controller.adminPassword=admin

# Esperar a que los pods de Jenkins estén listos
echo "Esperando a que Jenkins esté en ejecución..."
kubectl rollout status deployment/jenkins --namespace $NAMESPACE

# Obtener la IP de Minikube
MINIKUBE_IP=$(minikube ip)

# Mostrar URL de acceso
echo "Jenkins ha sido instalado correctamente."
echo "Accede a Jenkins desde tu navegador usando la siguiente URL:"
echo "http://$MINIKUBE_IP:32000"
