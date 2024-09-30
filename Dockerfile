FROM jenkins/inbound-agent:latest

USER root

# Instalar Docker utilizando un script oficial
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://get.docker.com | sh

# Habilitar uso de Docker sin root (opcional)
RUN usermod -aG docker jenkins

USER jenkins
#!/bin/bash

# Nombre del namespace de Jenkins
NAMESPACE="jenkins"

# Eliminar el deployment, services, pods, y otros recursos de Jenkins
echo "Eliminando todos los recursos en el namespace $NAMESPACE..."
kubectl delete all --all -n $NAMESPACE

# Eliminar el namespace de Jenkins
echo "Eliminando el namespace $NAMESPACE..."
kubectl delete namespace $NAMESPACE

# Eliminar los volúmenes persistentes
echo "Eliminando los PersistentVolumeClaims y PersistentVolumes..."
kubectl delete pvc --all -n $NAMESPACE
kubectl delete pv --all -n $NAMESPACE

# Verificar si hay otros recursos de Jenkins en otros namespaces
echo "Verificando si hay otros recursos de Jenkins en otros namespaces..."
kubectl get all --all-namespaces | grep jenkins | awk '{print $2}' | xargs kubectl delete -n $NAMESPACE

# Limpiar Minikube
echo "Limpiando Minikube..."
minikube delete --purge

# Eliminar cualquier volumen o disco residual
echo "Eliminando volúmenes persistentes restantes de Minikube..."
minikube ssh -- sudo rm -rf /var/lib/minikube/volumes

echo "Proceso de eliminación completado."
