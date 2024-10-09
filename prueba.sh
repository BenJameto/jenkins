#!/bin/bash

# Función para obtener los namespaces
get_namespaces() {
    # Almacenar la salida de kubectl en un arreglo
    namespaces=($(kubectl get namespaces -o name))

    # Remover el prefijo 'namespace/' de cada elemento
    for i in "${!namespaces[@]}"; do
        namespaces[$i]=${namespaces[$i]#namespace/}
    done

    # Imprimir la lista de namespaces
    echo "Namespaces: ${namespaces[@]}"
}

# Llamar a la función
get_namespaces
