# Usar Ubuntu 22.04 como base (ligero y compatible)
FROM ubuntu:22.04

# Evitar preguntas interactivas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar bash y limpiar caché de apt para reducir la imagen
RUN apt-get update && \
    apt-get install -y --no-install-recommends bash && \
    rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /app

# Copiar el script de la aplicación
COPY main.sh /app/main.sh

# Copiar archivos .inf de la aplicación
COPY *.inf /app/

# Dar permisos de ejecución al script (¡CRUCIAL!)
# IMPORTANTE
# SI LA LINEA DE ABAJO SE COMENTA ENTONCES EL PROGRAMA PODRÍA NO FUNCIONAR
RUN chmod +x /app/main.sh

# Comando que se ejecuta automáticamente al iniciar el contenedor
CMD ["./main.sh"]