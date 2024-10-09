import subprocess

def get_namespaces():
    # Ejecutar el comando kubectl get namespaces
    result = subprocess.run(["kubectl", "get", "namespaces", "-o", "name"], capture_output=True, text=True)
    
    # Procesar la salida y convertirla en una lista
    namespaces = result.stdout.splitlines()
    print(namespaces)
    
    # Eliminar el prefijo 'namespace/' de cada entrada
    namespaces = [ns.split("/")[1] for ns in namespaces]
    
    return namespaces


namespaces = get_namespaces()
print("Lista de namespaces:", namespaces)
