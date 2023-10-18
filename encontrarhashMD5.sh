#!/bin/bash

while getopts "d:h:" opt; do
  case $opt in
    d) carpeta="$OPTARG";;
    h) hash="$OPTARG";;
  esac
done

buscar_hash_en_archivo() {
    local archivo="$1"
    local hash="$2"

    # Calcular el hash MD5 del archivo actual
    local hash_archivo
    hash_archivo=$(md5sum "$archivo" | awk '{print $1}')

    if [ "$hash_archivo" == "$hash" ]; then
        echo "El hash MD5 $hash se ha encontrado en: $archivo"
        encontrado=true
    fi
}

# Buscar el hash MD5 en todos los archivos de la carpeta
encontrado=false

find "$carpeta" -type f | while read archivo; do
    buscar_hash_en_archivo "$archivo" "$hash"
done

if [ "$encontrado" == "false" ]; then
    echo "El hash MD5 $hash no se ha encontrado en ningun archivo"
fi
