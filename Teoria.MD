### Archivos en Bases de Datos

#### 1. Concepto de Archivo
Un archivo es una colección de registros homogéneos que se almacenan en un medio de almacenamiento secundario y sobre los cuales se realizan diversas operaciones de gestión de datos.

#### 1.1.1. Almacenamiento

- **Primario (RAM):** Volátil, limitado y costoso.
- **Secundario (Discos, Cintas):** No volátil, alta capacidad y más lento.

#### 1.1.2. Niveles de Visión

- **Físico:** Archivo existente en el almacenamiento, conocido por el sistema operativo.
- **Lógico:** Archivo existente en el programa, con operaciones sin conocer su ubicación física.

#### 1.1.3. Indexado en Pascal

- Los archivos son indexados desde 0.

#### 1.1.4. Tipos de Archivos

- **Archivo Maestro:** Resume información sobre un dominio específico.
- **Archivo Detalle:** Contiene información nueva generada por aplicaciones.

#### 1.2. Organización de un Archivo

**1.2.1. Archivos de Longitud Variable:**
- Los registros pueden tener diferentes tamaños y se utilizan delimitadores para indicar el final de campos y registros.

**1.2.2. Claves o Llaves:**
- **Claves Primarias:** Identifican de manera única los registros.
- **Claves Secundarias:** Pueden identificar múltiples registros, proporcionando una manera adicional de buscar datos.

**1.2.3. Accesos:**
- **Acceso Secuencial:** Los registros se acceden en un orden predefinido.
- **Acceso Directo:** Permite saltar directamente a un registro específico (solo con longitud fija).
- **Acceso Secuencial Indizado:** Combina el acceso secuencial con un índice que mejora la eficiencia de búsqueda.

#### 1.3. Cambios en Archivos

**1.3.1. Estáticos:**
- Pocos cambios, los cuales se pueden tratar por lotes recorriendo el archivo completo.

**1.3.2. Volátiles:**
- Alta frecuencia de cambios, lo que puede causar problemas en archivos de longitud variable debido a diferencias de tamaño entre registros nuevos y viejos.

#### 1.4. Bajas

**1.4.1. Fragmentación:**
- **Interna:** Desperdicio de espacio dentro de registros.
- **Externa:** Espacio libre no es suficiente para nuevos registros. Se pueden unir fragmentos adyacentes o compactar el archivo.

#### 1.5. Performance en Archivos
- **Búsqueda Secuencial:** \(O(n)\) en términos de eficiencia.
- **Búsqueda Binaria:** Requiere un archivo ordenado y proporciona una eficiencia de \(O(\log n)\).

#### 1.6. Ordenamiento

**1.6.1. Sort Interno:**
- Divide el archivo en particiones que se ordenan en memoria principal antes de ser fusionadas.

**1.6.2. Selección por Reemplazo:**
- Mantiene un buffer en memoria principal y duplica el tamaño de las particiones, reduciendo la cantidad de desplazamientos durante el merge.

**1.6.3. Indización:**

**1.6.3.1. Índice Primario:**
- Claves ordenadas que permiten la búsqueda eficiente y la gestión de altas y bajas.

**1.6.3.2. Índice Secundario:**
- Mejora la búsqueda asociando múltiples registros a una clave secundaria.

**1.6.3.3. Conclusión de Índices:**
- **Ventajas:** Permiten búsquedas binarias incluso si el archivo es de registros de longitud variable.
- **Desventajas:** Procesamiento adicional necesario para mantener las estructuras de índices.

### Árboles en Bases de Datos

#### 2. Árboles
Los árboles son estructuras de datos jerárquicas y no lineales que consisten en nodos conectados por aristas. Cada nodo contiene un valor y puede tener varios nodos hijos.

#### 2.1. Árboles Binarios

**2.1.1. Definición:**
- Un árbol binario es una estructura de datos en la que cada nodo tiene a lo sumo dos hijos, denominados hijo izquierdo e hijo derecho.

**2.1.1.1. Performance en Árboles Binarios:**
- La búsqueda en un árbol binario tiene una eficiencia de \(O(\log n)\) en el mejor caso, cuando el árbol está equilibrado. Si el árbol está desbalanceado, la búsqueda puede llegar a ser \(O(n)\).

#### 2.2. Árboles Balanceados

**2.2.1. AVL:**
- Los árboles AVL son árboles binarios balanceados en los que, para cada nodo, la diferencia de altura entre sus subárboles izquierdo y derecho es como máximo 1.
- **Ventaja:** Búsqueda rápida.
- **Desventaja:** Puede requerir muchas rotaciones para mantener el balance después de las inserciones y eliminaciones.

**2.2.2. Árboles Binarios Paginados:**
- Combinan el concepto de paginación (transferencia de múltiples datos en cada operación) con la estructura de los árboles binarios.
- **Performance:** Log\(k+1\)(N), donde k es el número de nodos que caben en un buffer.

**2.2.3. Árboles Multicamino:**
- Estructuras de datos en las que cada nodo puede tener k elementos y k+1 hijos.
- **Orden del Árbol Multicamino:** La máxima cantidad de descendientes posibles de un nodo.

**2.2.4. Árboles B (Balanceados):**
- Los árboles B son árboles multicamino balanceados que permiten un número variable de hijos por nodo y están diseñados para permanecer balanceados con un costo bajo.
- **Propiedades:**
  1. Cada nodo puede tener como máximo M hijos y M-1 elementos.
  2. La raíz puede no tener descendientes o tener al menos dos.
  3. Un nodo con x descendientes tiene x-1 elementos.
  4. Las hojas tienen al menos \(\lceil M/2 \rceil - 1\) elementos y como máximo M-1.
  5. Los nodos no terminales ni raíz tienen al menos \(\lceil M/2 \rceil\) hijos.
  6. Todas las hojas están en el mismo nivel.

**2.2.4.1. Declaración B:**
- La declaración de un árbol B en términos de código incluye la definición de arreglos para hijos y claves, y un contador para el número de registros.

**2.2.4.2. Construcción B:**
- La construcción de un árbol B se realiza hacia arriba, manteniendo el balance del árbol.

**2.2.4.3. Búsqueda en B:**
- La búsqueda se realiza de manera logarítmica en la altura del árbol. La eficiencia de la búsqueda es \(O(\log n)\), donde n es el número de claves.

**2.2.4.4. Inserción:**
- **Mejor Caso:** H lecturas y 1 escritura si no hay overflow.
- **Peor Caso:** \(2H + 1\) escrituras y H lecturas si el overflow se propaga hasta la raíz.

**2.2.4.5. Performance en la búsqueda:**
- Las búsquedas resultan en 1 acceso si el dato se encuentra en la raíz y en H accesos si el dato se encuentra en una hoja.

**2.2.4.6. Eliminación en B:**
- Eliminar un elemento puede requerir un proceso de reorganización para mantener el balance del árbol.

**2.2.4.6.1. Underflow:**
- Ocurre cuando un nodo tiene menos elementos de los requeridos después de una eliminación, lo que requiere redistribución o combinación de nodos.

**2.2.5. Árboles B*:**
- Los árboles B* son una mejora sobre los árboles B, diseñados para mantener los nodos más llenos y reducir la altura del árbol.
- **Ventajas:** Menor altura debido a nodos más llenos, lo que mejora la eficiencia de búsqueda, inserción y eliminación.

**2.2.5.1. Inserción:**
- En caso de overflow, se intenta redistribuir los elementos entre los nodos hermanos antes de dividir el nodo. Si no es posible, el nodo se divide y una copia del elemento se promociona al nodo padre.

**2.2.6. Árboles B+:**
- Los árboles B+ son una variante de los árboles B en la que los nodos hoja están vinculados entre sí para facilitar un acceso secuencial rápido.
- **Ventajas:** Accesos aleatorios rápidos y recorrido secuencial ordenado eficiente.
- **Diferencia clave:** Los nodos interiores contienen solo punteros, no datos.

**2.2.6.1. Prefijos Simples:**
- Los separadores en los nodos interiores contienen el mínimo prefijo necesario para diferenciar las claves mayores y menores.

**2.2.7. Comparación B vs B+:**
- **Árboles B:** Los nodos contienen datos y punteros. Menor uso de espacio en comparación con B+.
- **Árboles B+:** Los nodos interiores contienen solo punteros, los nodos hoja contienen todos los datos. Mayor espacio utilizado debido a los índices duplicados, pero mejor rendimiento en acceso secuencial.

### Dispersión en Bases de Datos

#### 3. Dispersión
La dispersión es una técnica que convierte la clave del registro en un número, utilizando una función de hash, para determinar dónde se almacena el registro. Esta técnica permite un acceso rápido y eficiente a los datos.

#### 3.1. Dispersión Estática

**3.1.1. Densidad de Empaquetamiento:**
- **Definición:** Relación entre el número de registros en un archivo y la capacidad total de las cubetas.
- **Fórmula:** \( DE = \frac{\text{Registros del archivo}}{\text{Capacidad total de cubetas}} \)
- Un DE menor indica menor saturación y menos colisiones, pero puede llevar a un mayor desperdicio de espacio.

**3.1.2. Tratamiento de Overflow:**
- **Colisiones:** Ocurren cuando dos claves diferentes generan la misma dirección en la tabla de hash. Estas claves son conocidas como sinónimos.

**3.1.2.1. Saturación Progresiva:**
- Cuando una dirección base está ocupada, se inserta el registro en el próximo lugar libre.
- Durante la búsqueda, se continúa hasta encontrar la clave, un espacio vacío o regresar a la dirección de arranque.
- **Marca de Borrado:** Se usa para indicar que la búsqueda no debe finalizar si se encuentra en una posición no vacía.

**3.1.2.2. Saturación con Área Separada:**
- Utiliza un área separada para manejar los registros que causan overflow.
- Puede ser lento si el área separada está en un cilindro diferente del disco.

**3.1.3. Hash Asistido por Tabla:**
- Utiliza una tabla auxiliar en memoria para mejorar la eficiencia de la recuperación.
- **Ventaja:** Recuperaciones rápidas.
- **Desventaja:** Inserciones lentas, útil cuando las recuperaciones son más frecuentes que las inserciones.

**3.1.4. Espacio no Disponible:**
- Cuando la densidad de empaquetamiento (DE) supera el 75%, se producen muchos overflows.
- Para manejar esto, se puede:
  1. Obtener más espacio.
  2. Actualizar la función de hash.
  3. Redistribuir el archivo.

**Redispersión:**
- Al aumentar el espacio disponible y actualizar la función de hash, todo el archivo se redistribuye.
- Problema: Durante la redispersión, el archivo no puede ser utilizado y el tiempo de redispersión puede ser largo.