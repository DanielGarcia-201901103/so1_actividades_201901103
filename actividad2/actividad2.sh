#!/bin/bash

# Leer la variable GITHUB_USER
GITHUB_USER=$1

# Validar que se haya pasado un usuario como argumento
if [ -z "$GITHUB_USER" ]; then
    echo "Debe proporcionar un nombre de usuario de GitHub."
    exit 1
fi

# Consultar la URL concatenando el valor de la variable GITHUB_USER
RESPONSE=$(curl -s "https://api.github.com/users/$GITHUB_USER")

# Extraer datos del JSON usando jq
USER_ID=$(echo $RESPONSE | jq -r '.id')
CREATED_AT=$(echo $RESPONSE | jq -r '.created_at')

# Imprimir el mensaje
MESSAGE="Hola $GITHUB_USER. User ID: $USER_ID. Cuenta fue creada el: $CREATED_AT."
echo $MESSAGE

# Crear un log file en /tmp/<fecha>/saludos.log
DATE=$(date +"%Y-%m-%d")
LOG_DIR="/tmp/$DATE"
LOG_FILE="$LOG_DIR/saludos.log"

mkdir -p $LOG_DIR
echo $MESSAGE >> $LOG_FILE


# Configurar crontab ****************************************************
# 1. ejecutar en la terminal:
#                           crontab -e
# 2. Dentro del archivo de crontab escribir:
#       */5 * * * * /home/usuario/actividad2.sh <GITHUB_USER>
# 3. Donde usuario es el usuario del sistema operativo, y <GITHUB_USER> es el usuario de github a elegir
# 4. guardar con ctrl + o y cerrar con ctrl + x
# 5. Si se desea revisar las tareas programadas con cron:
#       crontab -l
# 6. Para verificar los logs: grep CRON /var/log/syslog
# 7. Para revisar el archivo log:
#         cd /tmp/$(date +"%Y-%m-%d")
#         cat saludos.log
