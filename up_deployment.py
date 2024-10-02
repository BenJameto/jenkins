import subprocess

def scale_service(service_name, replicas):
    # Escalar el servicio en Kubernetes usando kubectl
    command = ["kubectl", "scale", "deployment", service_name, "--replicas", str(replicas)]
    result = subprocess.run(command, capture_output=True, text=True)
    
    if result.returncode == 0:
        print(f"Servicio {service_name} escalado a {replicas} réplicas.")
    else:
        print(f"Error escalando el servicio {service_name}: {result.stderr}")

if __name__ == "__main__":
    service_name = "nombre-del-servicio"  # Cambia por el nombre de tu servicio
    replicas = 3
    scale_service(service_name, replicas)
