import subprocess

def delete_all_pods():
    # Eliminar todos los pods usando kubectl
    command = ["kubectl", "delete", "pod", "--all"]
    result = subprocess.run(command, capture_output=True, text=True)
    
    if result.returncode == 0:
        print("Todos los pods fueron eliminados.")
    else:
        print(f"Error al eliminar los pods: {result.stderr}")

if __name__ == "__main__":
    delete_all_pods()
