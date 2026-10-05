#!/bin/bash

# ==============================================================================
# GUÍA INTERACTIVA DE METODOLOGÍAS DE DESARROLLO DE SOFTWARE
# Proyecto Primer Parcial - Desarrollo Basado en Plataformas
# Equipo 1
# Rafael Eduardo Acosta Navarro         - 374272
# Carlos Esteban Barragán Bernal        - 359299
# Giovanna Paulina Hernández Mendoza    - 377284
# Mario Mendoza Anchondo                - 374296
# ==============================================================================

# --- CONFIGURACIÓN INICIAL ---
# El Integrante 4 o quien gestione Docker puede ajustar esto si es necesario
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="${SCRIPT_DIR}/data" # Carpeta opcional para .inf, o usar ruta relativa directa

# ==============================================================================
# FUNCIONES DE UTILIDAD (Compartidas)
# ==============================================================================

limpiar_pantalla() {
    clear
}

mostrar_bienvenida() {
    local tipo=$1
    if [ "$tipo" == "agile" ]; then
        echo "Bienvenido a la guía rápida de Agile,"
        echo "para continuar seleccione un tema:"
    elif [ "$tipo" == "tradicional" ]; then
        echo "Bienvenido a la guía rápida de metodologías tradicionales,"
        echo "para continuar seleccione un tema:"
    fi
    echo ""
}

# --- MENÚ PRINCIPAL ---
menu_principal() {
    limpiar_pantalla
    echo "=========================================="
    echo "   GUÍA DE METODOLOGÍAS DE SOFTWARE       "
    echo "=========================================="
    echo "Seleccione el tipo de metodología:"
    echo "1. Metodologías Ágiles (-a)"
    echo "2. Metodologías Tradicionales (-t)"
    echo "0. Salir"
    echo "=========================================="
    read -p "Opción: " opcion
    
    case $opcion in
        1) ejecutar_modulo "agile" ;;
        2) ejecutar_modulo "tradicional" ;;
        0) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción no válida. Presione enter para continuar."; read; menu_principal ;;
    esac
}

# --- EJECUCIÓN POR PARÁMETROS ---
# Esta función se llama si se ejecuta el script con argumentos
ejecutar_con_parametros() {
    local param=$1
    case $param in
        -a) ejecutar_modulo "agile" ;;
        -t) ejecutar_modulo "tradicional" ;;
        *) 
            echo "Error: Parámetro inválido '$param'"
            echo "Uso: ./app.sh -a | ./app.sh -t"
            exit 1 
            ;;
    esac
}

# --- SELECCIÓN DE MÉTODOLOGÍA ---
ejecutar_modulo() {

}

# --- SUBMENÚ DE OPERACIONES ---
sub_menu_operaciones() {

}

# ==============================================================================
# FUNCIONES CRUD
# ==============================================================================

# 5.1 Agregar información
agregar_info() {
    local archivo=$1
    echo "--- AGREGAR INFORMACIÓN ---"
    read -p "Ingrese el concepto: " concepto
    read -p "Ingrese la definición: " definicion
    
    # Formato requerido: [concepto] .- Definición.
    local registro="[${concepto}] .- ${definicion}"
    
    # Asegurar que el archivo exista (crear vacío si no)
    touch "$archivo"
    
    # Agregar al final
    echo "$registro" >> "$archivo"
    
    echo "Información agregada correctamente."
    read -p "Presione Enter para continuar..."
}

# 5.2 Buscar información (Usar Regex)
buscar_info() {

}

# 5.3 Eliminar información
eliminar_info() {

}

# 5.4 Leer base de información
leer_info() {
    local archivo=$1
    echo "--- LEER BASE DE INFORMACIÓN ---"
    if [ ! -f "$archivo" ] || [ ! -s "$archivo" ]; then
        echo "La base de datos está vacía."
    else
        cat "$archivo"
    fi
    read -p "Presione Enter para continuar..."
}

# ==============================================================================
# PUNTO DE ENTRADA (MAIN)
# ==============================================================================

main() {
    # Si se pasaron argumentos, usarlos directamente
    if [ $# -gt 0 ]; then
        ejecutar_con_parametros "$1"
    else
        # Si no, mostrar menú interactivo
        menu_principal
    fi
}

# Ejecutar la función main pasando todos los argumentos del script
main "$@"