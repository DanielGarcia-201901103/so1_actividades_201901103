# Servicio de Saludo y fecha

Este es un servicio `systemd` que ejecuta un script que imprime un saludo y la fecha actual cada segundo.

## Instalación

1. Copiar el script `actividad.sh` y que sea ejecutable:
    ```bash
    sudo chmod +x /usr/local/bin/actividad.sh
    ```

2. Crear un archivo de unidad de `systemd` con el siguiente contenido:
    ```ini
    [Unit]
    Description=Servicio de Saludo

    [Service]
    ExecStart=/usr/local/bin/actividad.sh
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

3. Recargar los archivos de configuración de `systemd`:
    ```bash
    sudo systemctl daemon-reload
    ```

4. Habilitar el servicio para que se inicie automáticamente al arrancar el sistema:
    ```bash
    sudo systemctl enable actividad.service
    ```

5. Iniciar el servicio:
    ```bash
    sudo systemctl start actividad.service
    ```

## Verificación de logs

- Para verificar el estado del servicio:
    ```bash
    sudo systemctl status actividad.service
    ```

- Para ver los logs del servicio:
    ```bash
    sudo journalctl -u actividad.service
    ```

## Adicional se puede - Detener el Servicio y Eliminar archivos

1. Para detener el servicio:
    ```bash
    sudo systemctl stop actividad.service
    ```

2. Para deshabilitar el servicio del arranque automático:
    ```bash
    sudo systemctl disable actividad.service
    ```

3. Elimina el archivo de unidad del servicio:
    ```bash
    sudo rm /etc/systemd/system/actividad.service
    ```

4. Recarga los archivos de configuración de `systemd`:
    ```bash
    sudo systemctl daemon-reload
    ```

5. Opcional: elimina el script de saludo:
    ```bash
    sudo rm /usr/local/bin/actividad.sh
    ```