# Guía Interactiva de Metodologías de Desarrollo de Software

<!--
============================================================
 PROYECTO: PRIMER PARCIAL - DESARROLLO BASADO EN PLATAFORMAS
 UNIVERSIDAD AUTÓNOMA DE CHIHUAHUA - FACULTAD DE INGENIERÍA
============================================================
-->

## Datos académicos

| Campo | Detalle |
|---|---|
| **Universidad** | Universidad Autónoma de Chihuahua |
| **Facultad** | Facultad de Ingeniería |
| **Carrera** | Ingeniería en Ciencias de la Computación |
| **Materia** | Desarrollo Basado en Plataformas |
| **Docente** | Mtro. Luis Antonio Ramírez Martínez |
| **Actividad** | Proyecto del Primer Parcial: Guía interactiva de metodologías |
| **Integrantes** | Rafael Eduardo Acosta Navarro (374272), Carlos Esteban Barragán Bernal (359299), Giovanna Paulina Hernández Mendoza (377284), Mario Mendoza Anchondo (374296) |
| **Fecha de entrega** | Jueves, 8 de octubre de 2026|

## Descripción

Este proyecto consiste en una aplicación de línea de comandos (CLI) desarrollada en **Bash** que permite consultar y administrar información sobre metodologías de desarrollo de software, tanto ágiles (SCRUM, XP, Kanban, Crystal) como tradicionales (Cascada, Espiral, Modelo V).

La aplicación ofrece una interfaz interactiva basada en menús que permite:
- Navegar entre diferentes categorías de metodologías.
- Agregar nuevos conceptos y definiciones a bases de datos locales (archivos `.inf`).
- Buscar información específica utilizando expresiones regulares.
- Eliminar registros existentes sin afectar el resto de la base de datos.
- Visualizar todo el contenido almacenado.

El proyecto está empaquetado en un contenedor **Docker** para garantizar su portabilidad y ejecución independiente del sistema operativo.

## Objetivo

Desarrollar una aplicación en Bash que integre conocimientos de scripting, manejo de archivos, expresiones regulares, control de versiones (Git) y contenedores (Docker), cumpliendo con los requisitos de una guía interactiva funcional y modular.

## Tecnologías utilizadas

- **Lenguaje**: Bash (Bourne Again Shell)
- **Contenedores**: Docker
- **Control de Versiones**: Git / GitHub
- **Formato de datos**: Texto plano (.inf)
- **Sistema Operativo Base**: Unix

## Requisitos previos

Para ejecutar el proyecto desde el código fuente o desde la imagen Docker, se requiere:

- **Git**: Para clonar el repositorio.
- **Docker**: Versión 20.0 o superior (para construir y ejecutar el contenedor).
- **Bash**: Disponible en cualquier distribución Linux/macOS o WSL en Windows.
- **Cuenta en Docker Hub**: Para descargar la imagen pública (opcional si se construye localmente).

## Instalación

Sigue estos pasos para obtener y configurar el proyecto en tu máquina local:

```bash
# 1. Clona el repositorio
git clone https://github.com/359299/Proyecto-Primer-Parcial-Equipo1

# 2. Entra al directorio del proyecto
cd Proyecto-Primer-Parcial-Equipo1

# 3. (Opcional) Si deseas construir la imagen Docker localmente
docker build -t guia-metodologias:v1 .