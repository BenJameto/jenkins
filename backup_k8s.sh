#!/bin/bash

# Directorio donde se almacenará la configuración del clúster
BACKUP_DIR="k8s_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Espacio de nombres a respaldar (si deseas todos, utiliza " --all-namespaces ")
NAMESPACE="default"  # Puedes cambiar a otro namespace o "--all-namespaces" para todos

# Guarda los deployments
echo "Guardando Deployments..."
kubectl get deployments --namespace="$NAMESPACE" -o yaml > "$BACKUP_DIR/deployments.yaml"

# Guarda los services
echo "Guardando Services..."
kubectl get services --namespace="$NAMESPACE" -o yaml > "$BACKUP_DIR/services.yaml"

# Guarda los pods
echo "Guardando Pods..."
kubectl get pods --namespace="$NAMESPACE" -o yaml > "$BACKUP_DIR/pods.yaml"

# Guarda los configmaps
echo "Guardando ConfigMaps..."
kubectl get configmaps --namespace="$NAMESPACE" -o yaml > "$BACKUP_DIR/configmaps.yaml"

# Guarda los secrets
echo "Guardando Secrets..."
kubectl get secrets --namespace="$NAMESPACE" -o yaml > "$BACKUP_DIR/secrets.yaml"

# Guarda los ingress (si aplica)
echo "Guardando Ingress..."
kubectl get ingress --namespace="$NAMESPACE" -o yaml > "$BACKUP_DIR/ingress.yaml"

# Guarda los persistent volume claims (PVCs)
echo "Guardando PersistentVolumeClaims..."
kubectl get pvc --namespace="$NAMESPACE" -o yaml > "$BACKUP_DIR/pvcs.yaml"

# Comprime los archivos de configuración en un archivo .tar.gz
echo "Comprimido el backup en un archivo tar.gz..."
tar -czvf "$BACKUP_DIR.tar.gz" "$BACKUP_DIR"

# Limpia el directorio temporal
rm -rf "$BACKUP_DIR"

echo "Respaldo completado. Archivo guardado como $BACKUP_DIR.tar.gz"
