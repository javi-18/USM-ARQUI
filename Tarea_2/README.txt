Javiera Bobadilla;202173584-4;Paralelo 200
Elias Valle;202173537-2; Paralelo 200

El circuito se construyo usando la versión 2.7.1 de Logisim
Debido a que se debe llegar siempre a un mismo punto que representa la salida del laberinto, el circuito siempre entrega la dirección más cercana a la salida, haciendo que el robot vaya a la coordenada que lo lleve hacia ella

Debido a la cantidad de combinaciones que tiene, se dividio en varios subcircuitos donde:
- siguiente posicion= guarda la coordenada más cerca a la salida
- Flip flpo D = guarda la posicion de 1 de los bits 
- memory = Guarda los 3 bits de cada una de las coordenadas
- salida= retorna el movimiento de la coordenada
- memoria final= guarda los 3 bits de todas las entradas posibles 
- siguiente posicion final = repite la accion del subcircuito siguiente posición para todas las coordenadas 
- salida final= repite la accion del subcircuito salida para todas las coordenadas

Para ejecutar el circuito basta simplemente con poner una coordenada en el subcircuito main y activar la simulacion en la pestaña simular, el cual activa todos los demás subcircuitos a una frecuencia de 1 hz
Si se quiere volver a probar basta simplemente con reiniciar la simulacion y poner otra coordenada válida del laberinto, para así volvera a ejecutar el circuito



