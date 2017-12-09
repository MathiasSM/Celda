# Proyecto de Prolog - La Leyenda de Celda

+ `13-11310` - Mathias San Miguel
+ `13-10488` - Julio Fuenmayor

---
             
## DETALLES DE IMPLEMENTACIÓN

- Se crearon los predicados auxiliares `onoff\1` y `completo\2` con el fin de poder instanciar correctamente los interruptores. `onoff\1` se encarga de seleccionar los modos de los interruptores y `completo\2` se encarga de emparejar las etiquetas de los pasillos con la de los interruptores.

- Para mayor eficiencia, la lista de interruptores se ordeno de manera lexicográfica por las etiquetas de los pasillos.

---

## INSTRUCCIONES DE EJECUCIÓN

- Ejecutar `swipl`
- Cargar el archivo de la siguiente forma: 
    `$> [celda].`
- Ejecutar main: 
    `$> main.`
- Introducir un nombre de archivo con un mapa
