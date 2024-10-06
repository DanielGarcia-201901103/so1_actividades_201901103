# Completely Fair Scheduler (CFS) de linux.

1. ### **Características Principales**

- **Equidad en la asignación de CPU:** CFS no utiliza tiempos de ejecución basados en intervalos de tiempo (time slices) predefinidos. En su lugar, asigna una proporción de tiempo de CPU a cada tarea, basada en el valor "nice" de la misma, lo que proporciona una distribución justa del tiempo de CPU entre las tareas.

- **Planificación basada en clases:** El sistema Linux puede tener varias clases de planificación, cada una con diferentes algoritmos de planificación. CFS es la clase predeterminada en la mayoría de los casos, pero el kernel puede incorporar otras clases, como la planificación en tiempo real.

- **Utilización de "vruntime":** CFS registra el tiempo de ejecución virtual ("vruntime") de cada tarea para determinar cuál debe ejecutarse a continuación. Este valor se ajusta según la prioridad de la tarea, lo que significa que las tareas con mayor prioridad tienen tiempos de ejecución virtual más bajos.

- **Sensibilidad a sistemas NUMA y multi-core:** CFS es consciente de la arquitectura de sistemas multi-core y NUMA (Non-Uniform Memory Access), lo que le permite equilibrar cargas entre los procesadores sin incurrir en penalizaciones de rendimiento por el acceso a memoria remota.

- **Planificación interactiva y sensible a la prioridad:** Las tareas con menor valor de nice (mayor prioridad) reciben más tiempo de CPU que las de mayor nice. Además, las tareas en tiempo real tienen prioridad absoluta sobre las tareas normales.

- **Escalabilidad:** Diseñado para funcionar eficientemente en sistemas con múltiples procesadores y grandes números de tareas activas.

2. ### **Funcionamiento**

- **Asignación proporcional del tiempo de CPU:** Cada tarea recibe una proporción de tiempo de CPU según su valor nice. Las tareas con valores más bajos de nice reciben una mayor proporción de tiempo, mientras que las tareas con valores más altos (menos prioridad) obtienen menos tiempo.

- **Balanceo de carga:** CFS distribuye la carga de trabajo entre los núcleos de procesamiento, minimizando la migración de hilos para evitar penalizaciones de rendimiento en sistemas NUMA.

- **Manejo del tiempo de ejecución virtual:** CFS rastrea el "vruntime" de cada tarea y siempre selecciona la tarea con el menor vruntime para ejecutarse a continuación. Esto garantiza que todas las tareas tengan oportunidades justas de ejecución. Si una tarea tiene mayor prioridad (valor de nice bajo), su vruntime crece más lentamente, lo que le da ventaja sobre otras tareas.

- **Ejecución interrumpida:** Si una tarea de mayor prioridad se vuelve elegible para ejecutarse (por ejemplo, cuando una tarea I/O-bound finaliza una operación de entrada/salida), esta puede interrumpir a una tarea de menor prioridad que esté ejecutándose.

- **Latencia objetivo:** En lugar de trabajar con un intervalo de tiempo fijo por tarea, CFS emplea una latencia objetivo, que es un tiempo dentro del cual cada tarea debería ejecutarse al menos una vez.