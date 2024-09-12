# Actividad 6 – Procesos e Hilos

## 1. ¿Incluyendo el proceso inicial, cuantos procesos son creados por el siguiente programa?Razone su respuesta.

Cada vez que fork() es llamado se crea un nuevo proceso. En total se crean 8 procesos, esto debido a que al llamar por primera vez al proceso inicial, se crea un proceso nuevo por lo cual crea otro proceso y cuando estos dos procesos vuelven a llamar a fork() se duplica la cantidad de procesos, por lo que hay 4 procesos y al hacer el proceso nuevamente se crean otros 4 procesos.

## 2. Utilizando un sistema Linux, escriba un programa en C que cree un proceso hijo (fork) que finalmente se convierta en un proceso zombie. Este proceso zombie debe permanecer en el sistema durante al menos 60 segundos. Los estados del proceso se pueden obtener del comando: ps -l

```
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork(); 
    if (pid < 0) {
        perror("Error al crear el proceso");
        exit(1);
    } else if (pid == 0) {
        printf("Proceso hijo (PID: %d) terminado.\n", getpid());
        exit(0);
    } else {
        printf("Proceso padre (PID: %d) con hijo (PID: %d) en estado zombie durante 60 segundos.\n", getpid(), pid);
        sleep(60); 
        wait(NULL);  
        printf("Proceso zombie (PID: %d) limpiado.\n", pid);
    }
    return 0;
} 
```

## 3. Usando el siguiente código como referencia, completar el programa para que sea ejecutable y responder las siguientes preguntas:

```
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>


void* thread_function(void* arg) {
    printf("Hilo ejecutado en el proceso hijo.\n");
    pthread_exit(NULL); 
}

int main() {
    pid_t pid;
    pthread_t thread_id;
    pid = fork();
    if (pid < 0) {
        perror("Error al crear el primer proceso");
        exit(1);
    }
    if (pid == 0) { 
        fork();
        if (pthread_create(&thread_id, NULL, thread_function, NULL) != 0) {
            perror("Error al crear el hilo");
            exit(1);
        }
        fork();
        pthread_join(thread_id, NULL);
    }
    sleep(1); 
    return 0;
}

```
• ¿Cuántos procesos únicos son creados?

4 procesos, esto incluye al proceso padre.

• ¿Cuántos hilos únicos son creados?

1 único hilo.