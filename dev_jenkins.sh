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
  --set controller.admin.username=admin \
  --set controller.admin.password=admin

echo "http://$MINIKUBE_IP:32000"navegador usando la siguiente URL:"
Creando el namespace jenkins si no existe...
namespace/jenkins created
Agregando el repositorio de charts de Jenkins a Helm...
"jenkins" already exists with the same configuration, skipping
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "jenkins" chart repository
...Successfully got an update from the "gitlab" chart repository
Update Complete. ⎈Happy Helming!⎈
Instalando Jenkins en el namespace jenkins...
NAME: jenkins
LAST DEPLOYED: Mon Sep 30 15:41:01 2024
NAMESPACE: jenkins
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:
  kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  export NODE_PORT=$(kubectl get --namespace jenkins -o jsonpath="{.spec.ports[0].nodePort}" services jenkins)
  export NODE_IP=$(kubectl get nodes --namespace jenkins -o jsonpath="{.items[0].status.addresses[0].address}")
  echo http://$NODE_IP:$NODE_PORT

3. Login with the password from step 1 and the username: admin
4. Configure security realm and authorization strategy
5. Use Jenkins Configuration as Code by specifying configScripts in your values.yaml file, see documentation: http://$NODE_IP:$NODE_PORT/configuration-as-code and examples: https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos

For more information on running Jenkins on Kubernetes, visit:
https://cloud.google.com/solutions/jenkins-on-container-engine

For more information about Jenkins Configuration as Code, visit:
https://jenkins.io/projects/jcasc/


NOTE: Consider using a custom image with pre-installed plugins
Esperando a que Jenkins esté en ejecución...
Error from server (NotFound): deployments.apps "jenkins" not found
Jenkins ha sido instalado correctamente.
Accede a Jenkins desde tu navegador usando la siguiente URL:
http://192.168.49.2:32000