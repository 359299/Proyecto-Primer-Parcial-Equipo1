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
local categoria=$1
    local metodo=""
    local archivo_inf=""
    
    # Mapeo de categorías a opciones
    if [ "$categoria" == "agile" ]; then
        echo "Usted está en la sección Metodologías Ágiles"
        echo "1. SCRUM"
        echo "2. XP (Programación Extrema)"
        echo "3. Kanban"
        echo "4. Crystal"
        echo "0. Volver al menú principal"
        read -p "Seleccione una metodología: " opt_metodo
        
        case $opt_metodo in
            1) metodo="scrum"; archivo_inf="scrum.inf" ;;
            2) metodo="xp"; archivo_inf="xp.inf" ;;
            3) metodo="kanban"; archivo_inf="kanban.inf" ;;
            4) metodo="crystal"; archivo_inf="crystal.inf" ;;
            0) menu_principal ;;
            *) echo "Opción inválida."; read; ejecutar_modulo "$categoria" ;;
        esac
    elif [ "$categoria" == "tradicional" ]; then
        echo "Usted está en la sección Metodologías Tradicionales"
        echo "1. Cascada"
        echo "2. Espiral"
        echo "3. Modelo V"
        echo "0. Volver al menú principal"
        read -p "Seleccione una metodología: " opt_metodo
        
        case $opt_metodo in
            1) metodo="cascada"; archivo_inf="cascada.inf" ;;
            2) metodo="espiral"; archivo_inf="espiral.inf" ;;
            3) metodo="modelo-v"; archivo_inf="modelo-v.inf" ;;
            0) menu_principal ;;
            *) echo "Opción inválida."; read; ejecutar_modulo "$categoria" ;;
        esac
    fi

    # Si se seleccionó una metodología válida, pasar al submenú de operaciones
    if [ -n "$metodo" ]; then
        sub_menu_operaciones "$metodo" "$archivo_inf"
    fi
}

# --- SUBMENÚ DE OPERACIONES ---
sub_menu_operaciones() {
local metodo=$1
    local archivo=$2
    
    while true; do
        limpiar_pantalla
        echo "=========================================="
        echo "   SECCIÓN: ${metodo^^} (Archivo: $archivo)"
        echo "=========================================="
        echo "1. Agregar información"
        echo "2. Buscar información"
        echo "3. Eliminar información"
        echo "4. Leer base de información"
        echo "5. Volver al menú anterior"
        echo "0. Salir de la aplicación"
        echo "=========================================="
        read -p "Seleccione una opción: " accion

        case $accion in
            1) agregar_info "$archivo" ;;
            2) buscar_info "$archivo" ;;
            3) eliminar_info "$archivo" ;;
            4) leer_info "$archivo" ;;
            5) break ;; # Rompe el loop y vuelve a ejecutar_modulo
            0) echo "Saliendo..."; exit 0 ;;
            *) echo "Opción no válida."; sleep 1 ;;
        esac
    done
    
    # Si salió del loop, volver al menú de selección de metodología
    # Nota: Aquí necesitamos saber la categoría original. 
    # Para simplificar en este esqueleto, asumimos que si sale, vuelve al inicio.
    # En una versión más robusta, pasaríamos 'categoria' como argumento extra.
    if [ "$metodo" == "scrum" ] || [ "$metodo" == "xp" ] || [ "$metodo" == "kanban" ] || [ "$metodo" == "crystal" ]; then
        ejecutar_modulo "agile"
    else
        ejecutar_modulo "tradicional"
    fi
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
    local archivo=$1
    echo "--- BUSCAR INFORMACIÓN ---"
    read -p "Ingrese el concepto a buscar: " concepto_buscar
    
    if [ ! -f "$archivo" ]; then
        echo "No hay información registrada aún."
        read -p "Presione Enter para continuar..."
        return
    fi

    # Regex para encontrar [concepto] exacto
    # El patrón busca: [texto_buscar] seguido de espacio y .-
    patron="\[${concepto_buscar}\]"
    
    resultado=$(grep -i "$patron" "$archivo")
    
    if [ -n "$resultado" ]; then
        echo "Resultado encontrado:"
        echo "$resultado"
    else
        echo "El concepto '${concepto_buscar}' no existe en la base de datos."
    fi
    read -p "Presione Enter para continuar..."
}

# 5.3 Eliminar información
eliminar_info() {
    local archivo=$1
    echo "--- ELIMINAR INFORMACIÓN ---"
    read -p "Ingrese el concepto a eliminar: " concepto_eliminar
    
    if [ ! -f "$archivo" ]; then
        echo "No hay información registrada."
        read -p "Presione Enter para continuar..."
        return
    fi

    patron="\[${concepto_eliminar}\]"
    
    if grep -q "$patron" "$archivo"; then
        # Crear archivo temporal, filtrar la línea y reemplazar el original
        # grep -v invierte la búsqueda (excluye la línea que coincide)
        grep -v "$patron" "$archivo" > "${archivo}.tmp" && mv "${archivo}.tmp" "$archivo"
        echo "Concepto eliminado correctamente."
    else
        echo "El concepto no fue encontrado."
    fi
    read -p "Presione Enter para continuar..."
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